#!/bin/bash
#FLUX: --job-name=unique_name
#FLUX: -c=40
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_JOB_CPUS_PER_NODE}'
export SINGULARITY_BIND='${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server'
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT='0'
export SINGULARITYENV_USER='$(id -un)'
export SINGULARITYENV_PASSWORD='$(echo $RANDOM | base64 | head -c 20)'

module load java/11.0.5
module load singularity/3.5.2
workdir=$(python -c 'import tempfile; print(tempfile.mkdtemp())')
mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END
cat > ${workdir}/rsession.sh <<END
export OMP_NUM_THREADS=${SLURM_JOB_CPUS_PER_NODE}
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END
chmod +x ${workdir}/rsession.sh
export SINGULARITY_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server"
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0
export SINGULARITYENV_USER=$(id -un)
export SINGULARITYENV_PASSWORD=$(echo $RANDOM | base64 | head -c 20)
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:
   ssh -N -L 8787:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@LOGIN-HOST
   and point your web browser to http://localhost:8787
2. log in to RStudio Server using the following credentials:
   user: ${SINGULARITYENV_USER}
   password: ${SINGULARITYENV_PASSWORD}
When done using RStudio Server, terminate the job by:
1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:
      scancel -f ${SLURM_JOB_ID}
END
singularity exec --cleanenv -H $PWD:/home/rstudio docker://alemenze/abrfseurat \
    /usr/lib/rstudio-server/bin/rserver --server-user ${USER} --www-port ${PORT} \
            --auth-none=0 \
            --auth-pam-helper-path=pam-helper \
            --auth-stay-signed-in-days=30 \
            --auth-timeout-minutes=0 \
            --rsession-path=/etc/rstudio/rsession.sh 
printf 'rserver exited' 1>&2
