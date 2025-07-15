#!/bin/bash
#FLUX: --job-name=lovable-mango-6712
#FLUX: -c=50
#FLUX: -t=3888000
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_JOB_CPUS_PER_NODE}'
export R_LIBS_USER='${HOME}/R/jrocker/4.2'
export SINGULARITY_BIND='${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server,/scr1/users/liuc9:/scr1/users/liuc9,/mnt/isilon/xing_lab/liuc9:/mnt/isilon/xing_lab/liuc9,/mnt/isilon/xing_lab/aspera:/mnt/isilon/xing_lab/aspera'
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT='0'
export SINGULARITYENV_USER='$(id -un)'
export SINGULARITYENV_PASSWORD='u201012670'

workdir=$(python -c 'import tempfile;from pathlib import Path; print(tempfile.mkdtemp(prefix="jrocker_", dir=str(Path.home()/"tmp/tmp")))')
mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END
cat > ${workdir}/rsession.sh <<END
export OMP_NUM_THREADS=${SLURM_JOB_CPUS_PER_NODE}
export R_LIBS_USER=${HOME}/R/jrocker/4.2
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END
chmod +x ${workdir}/rsession.sh
export SINGULARITY_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server,/scr1/users/liuc9:/scr1/users/liuc9,/mnt/isilon/xing_lab/liuc9:/mnt/isilon/xing_lab/liuc9,/mnt/isilon/xing_lab/aspera:/mnt/isilon/xing_lab/aspera"
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0
export SINGULARITYENV_USER=$(id -un)
export SINGULARITYENV_PASSWORD=$(openssl rand -base64 15)
export SINGULARITYENV_PASSWORD="u201012670"
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:
   ssh -N -L ${PORT}:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@hpc
   and point your web browser to http://localhost:${PORT}
2. log in to RStudio Server using the following credentials:
   user: ${SINGULARITYENV_USER}
   password: ${SINGULARITYENV_PASSWORD}
When done using RStudio Server, terminate the job by:
1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:
      scancel -f ${SLURM_JOB_ID}
END
singularity exec --cleanenv ${HOME}/sif/jrocker_latest.sif \
   /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} \
   --auth-none=0 \
   --auth-pam-helper-path=pam-helper \
   --auth-stay-signed-in-days=30 \
   --auth-timeout-minutes=0 \
   --server-user=${SINGULARITYENV_USER} \
   --rsession-path=/etc/rstudio/rsession.sh
printf 'rserver exited' 1>&2
