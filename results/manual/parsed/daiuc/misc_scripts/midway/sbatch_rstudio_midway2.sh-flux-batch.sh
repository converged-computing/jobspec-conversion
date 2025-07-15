#!/bin/bash
#FLUX: --job-name=rstudio
#FLUX: -t=129540
#FLUX: --priority=16

export SINGULARITYENV_USER='chaodai'
export SINGULARITYENV_RSTUDIO_WHICH_R='${R_BIN}'
export SINGULARITYENV_CONDA_PREFIX='${CONDA_PREFIX}'
export SINGULARITYENV_PATH='/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway2/chaodai/miniconda3/envs/sos/bin:\$PATH'
export SINGULARITYENV_LD_LIBRARY_PATH='/scratch/midway2/chaodai/miniconda3/envs/sos/lib:$LD_LIBRARY_PATH'
export SINGULARITYENV_CACHEDIR='/scratch/midway2/chaodai/singularity/singularity_cache'
export SINGULARITYENV_RSTUDIO_PASS='$RSTUDIO_PASS'

cd ~ && source ~/.bash_profile && pwd 
echo -e "\n Submited job: $SLURM_JOB_ID\n\n\n" 
module load singularity/3.4.0 #gcc/10.1.0
conda activate sos
JPORT=9798 # configured in .jupyter/jupyter_server_config.py
RPORT=8282 # for rstudio
CPORT=8783 # configured in .config/code-server/config.yaml
IP=$(/sbin/ip route get 8.8.8.8 | awk '{print $NF;exit}')
echo -e "### DATE: $(date) ### \n" 
echo -e "### IP: ${IP}\n\n" 
echo -e "\n\n### 1.  Jupyter ###"
echo -e "jupyter server runing on http://${IP}:${JPORT}/lab \n" 
jupyter lab --port=$JPORT  &
echo -e "\n\n### 2.  Rstudio ###"
echo "rstudio server running on http://${IP}:${RPORT}" 
SIF="/scratch/midway2/chaodai/singularity/rstudio_rstudio-2023_10.sif"
RSTUDIO_TMP=/scratch/midway2/chaodai//singularity/rstudio-tmp
echo "using image $SIF" >> showRstudioAddress.txt
echo -e "---------------\n\n\n"
CONDA_PREFIX=/scratch/midway2/chaodai/miniconda3/envs/sos
R_BIN=$CONDA_PREFIX/bin/R
PY_BIN=$CONDA_PREFIX/bin/python
export SINGULARITYENV_USER=chaodai
export SINGULARITYENV_RSTUDIO_WHICH_R=${R_BIN}
export SINGULARITYENV_CONDA_PREFIX=${CONDA_PREFIX}
export SINGULARITYENV_PATH="/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway2/chaodai/miniconda3/envs/sos/bin:\$PATH"
export SINGULARITYENV_LD_LIBRARY_PATH="/scratch/midway2/chaodai/miniconda3/envs/sos/lib:$LD_LIBRARY_PATH"
export SINGULARITYENV_CACHEDIR="/scratch/midway2/chaodai/singularity/singularity_cache"
export SINGULARITYENV_RSTUDIO_PASS=$RSTUDIO_PASS
RSTUDIO_SERVER_USER=chaodai # change to your own
sleep 5
PASSWORD=${RSTUDIO_PASS} singularity exec \
    --bind $RSTUDIO_TMP/var/lib:/var/lib/rstudio-server \
    --bind $RSTUDIO_TMP/var/run:/var/run/rstudio-server \
    --bind $RSTUDIO_TMP/tmp:/tmp \
    --bind $RSTUDIO_TMP/database.conf:/etc/rstudio/database.conf \
    --bind $RSTUDIO_TMP/rsession.conf:/etc/rstudio/rsession.conf \
    --bind $RSTUDIO_TMP/rserver.conf:/etc/rstudio/rserver.conf \
    --bind $RSTUDIO_TMP/logging.conf:/etc/rstudio/logging.conf \
    --bind $RSTUDIO_TMP/file-locks:/etc/rstudio/file-locks \
    --bind /sys/fs/cgroup/:/sys/fs/cgroup/:ro \
    --bind /home/chaodai:/home/rstudio \
    --bind /project2,/scratch/midway2/chaodai,/software,/usr/bin/tclsh \
    $SIF \
    rserver --server-user $RSTUDIO_SERVER_USER \
        --rsession-which-r=${R_BIN} \
        --www-port=${RPORT} \
        --auth-none=0 \
        --auth-pam-helper-path=pam-helper \
        --auth-timeout-minutes=0 \
        --auth-stay-signed-in-days=30 \
        --secure-cookie-key-file=/home/chaodai/rstudio-server/secure-cookie-key
