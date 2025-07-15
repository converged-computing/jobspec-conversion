#!/bin/bash
#FLUX: --job-name=butterscotch-plant-7385
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_JOB_CPUS_PER_NODE}'
export R_LIBS_USER='${HOME}/.rstudio-age/rocker-rstudio/${RSTUDIO_VERSION}'
export APPTAINER_BIND='${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server'
export APPTAINERENV_USER='$(id -un) '
export APPTAINERENV_PASSWORD='$(openssl rand -base64 15)'

RSTUDIO_IMAGE="/nexus/posix0/MAGE-flaski/service/images/rstudio_4.2.sif"
RSTUDIO_VERSION="4.2"
[ -n "$IMAGE" ] && RSTUDIO_IMAGE="$IMAGE"
[ -n "$R_VER" ] && RSTUDIO_VERSION="$R_VER"
while getopts "i:v:" opt; do
    case $opt in
        i) RSTUDIO_IMAGE="$OPTARG" ;;
        v) RSTUDIO_VERSION="$OPTARG" ;;
        *) exit 1 ;;
    esac
done
mkdir -p ~/.rstudio-age/tmp
workdir=$(python3 -c 'import tempfile; import os; HOME=os.getenv("HOME"); print(tempfile.mkdtemp(prefix=f"{HOME}/.rstudio-age/tmp/"))')
mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END
if [ "${SLURM_JOB_CPUS_PER_NODE}" = "" ] ; then SLURM_JOB_CPUS_PER_NODE=2 ; fi
cat > ${workdir}/rsession.sh <<END
export OMP_NUM_THREADS=${SLURM_JOB_CPUS_PER_NODE}
export R_LIBS_USER=${HOME}/.rstudio-age/rocker-rstudio/${RSTUDIO_VERSION}
mkdir -p ${HOME}/.rstudio-age/rocker-rstudio/${RSTUDIO_VERSION}
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END
chmod +x ${workdir}/rsession.sh
export APPTAINER_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server"
export APPTAINERENV_USER=$(id -un) 
export APPTAINERENV_PASSWORD=$(openssl rand -base64 15)
readonly PORT=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
NODEIP=$(hostname -I | grep -Eo '192\.168\.42\.[0-9]+')
cat 1>&2 <<END
ATTENTION: RStudio Server Community Edition only provides unencrypted HTTP access.
1. Run from local computer: ssh -N -L 8787:${NODEIP}:${PORT} -J ${APPTAINERENV_USER}@raven.mpcdf.mpg.de ${APPTAINERENV_USER}@hpc.bioinformatics.studio
   and point your web browser to http://localhost:8787
2. log in to RStudio Server using the following credentials:
   user: ${APPTAINERENV_USER}
   password: ${APPTAINERENV_PASSWORD}
When done using RStudio Server, terminate the job by:
1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window) & end the ssh port tunneling from the local computer terminal
END
if [ "${SLURM_JOB_ID}" = "" ] ; then
cat 1>&2 <<END   
END
else
cat 1>&2 <<END
2. Issue the following command on the login node:
      scancel -f ${SLURM_JOB_ID}
END
fi
singularity exec --cleanenv ${RSTUDIO_IMAGE} \
    /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} \
            --auth-none=0 \
            --auth-pam-helper-path=pam-helper \
            --auth-stay-signed-in-days=30 \
            --auth-timeout-minutes=0 \
            --rsession-path=/etc/rstudio/rsession.sh \
            --server-user=${APPTAINERENV_USER}
printf 'rserver exited' 1>&2
