#!/bin/bash
#FLUX: --job-name=rstudio
#FLUX: -t=129540
#FLUX: --priority=16

export SINGULARITYENV_USER='chaodai'
export SINGULARITYENV_RSTUDIO_WHICH_R='${R_BIN}'
export SINGULARITYENV_CONDA_PREFIX='${CONDA_PREFIX}'
export SINGULARITYENV_PATH='/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/chaodai/.pyenv/shims:/opt/pyenv/bin:/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway3/chaodai/miniconda3/envs/smk/bin:\$PATH'
export SINGULARITYENV_CACHEDIR='/scratch/midway3/chaodai/singularity/singularity_cache'
export SINGULARITYENV_RSTUDIO_PASS='$RSTUDIO_PASS'

log=logs/sbatchLogRstudioContainer.log
cd ~ && source ~/.bash_profile && pwd >$log
echo -e "\n Submited job: $SLURM_JOB_ID\n\n\n" >> $log
module load singularity/3.9.2 &>> $log # different from midway2
conda activate smk &>> $log
JPORT=9798 # configured in .jupyter/jupyter_server_config.py
RPORT=8282 # for rstudio
IP=$(/sbin/ip route get 8.8.8.8 | awk '{print $(NF-2);exit}') # different from midway2
echo -e "### DATE: $(date) ### \n" >> $log
echo -e "### IP: ${IP}\n\n" >> $log
echo -e "\n\n### 1.  Jupyter ###"
echo -e "jupyter server runing on http://${IP}:${JPORT}/lab \n" >> $log
jupyter lab --port=$JPORT  >> $log &
echo -e "\n\n### 2.  Rstudio ###"
echo "rstudio server running on http://${IP}:${RPORT}" >> $log
SIF="/scratch/midway3/chaodai/singularity/rstudio_2022_12.sif"
RSTUDIO_TMP=/scratch/midway3/chaodai/singularity/rstudio-tmp
echo "using image $SIF" >> showRstudioAddress.txt
echo -e "---------------\n\n\n"
CONDA_PREFIX=/scratch/midway3/chaodai/miniconda3/envs/smk
R_BIN=$CONDA_PREFIX/bin/R
PY_BIN=$CONDA_PREFIX/bin/python
export SINGULARITYENV_USER=chaodai
export SINGULARITYENV_RSTUDIO_WHICH_R=${R_BIN}
export SINGULARITYENV_CONDA_PREFIX=${CONDA_PREFIX}
export SINGULARITYENV_PATH="/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/chaodai/.pyenv/shims:/opt/pyenv/bin:/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway3/chaodai/miniconda3/envs/smk/bin:\$PATH"
export SINGULARITYENV_CACHEDIR="/scratch/midway3/chaodai/singularity/singularity_cache"
export SINGULARITYENV_RSTUDIO_PASS=$RSTUDIO_PASS
RSTUDIO_SERVER_USER=chaodai # change to your own
sleep 5 
PASSWORD=${MY_PASS} singularity exec \
    --bind $RSTUDIO_TMP/var/lib:/var/lib/rstudio-server \
    --bind $RSTUDIO_TMP/var/run:/var/run/rstudio-server \
    --bind $RSTUDIO_TMP/tmp:/tmp \
    --bind $RSTUDIO_TMP/database.conf:/etc/rstudio/database.conf \
    --bind /sys/fs/cgroup/:/sys/fs/cgroup/:ro \
    --bind /home/chaodai:/home/rstudio \
    --bind /project2/yangili1:/project2/yangili1 \
    --bind /project2/jstaley:/project2/jstaley \
    --bind /scratch/midway3/chaodai:/scratch/midway3/chaodai \
    $SIF \
    rserver --server-user $RSTUDIO_SERVER_USER \
        --rsession-which-r=${R_BIN} \
        --www-port=${RPORT} \
        --auth-none=0 \
        --auth-pam-helper-path=pam-helper \
        --auth-timeout-minutes=0 \
        --auth-stay-signed-in-days=30 \
        --secure-cookie-key-file=/home/chaodai/rstudio-server/secure-cookie-key
