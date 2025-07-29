#!/bin/bash
#FLUX: --job-name=rstudio
#FLUX: -c=4
#FLUX: --queue=broadwl
#FLUX: -t=129540
#FLUX: --urgency=16

export SINGULARITYENV_USER='chaodai'
export SINGULARITYENV_RSTUDIO_WHICH_R='${R_BIN}'
export SINGULARITYENV_CONDA_PREFIX='${CONDA_PREFIX}'
export SINGULARITYENV_PATH='/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/chaodai/.pyenv/shims:/opt/pyenv/bin:/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway2/chaodai/miniconda3/envs/smk/bin'
export SINGULARITYENV_CACHEDIR='/scratch/midway2/chaodai/singularity/singularity_cache'

source ~/.bash_profile
log=logs/sbatchLogRstudioContainer.log
echo -e "\n Submited job: $SLURM_JOB_ID\n\n\n" > $log
module load singularity/3.4.0 &>> $log
conda activate smk &>> $log
JPORT=9798 # configured in .jupyter/jupyter_server_config.py
RPORT=8282 # for rstudio
CPORT=8783 # configured in .config/code-server/config.yaml
IP=$(/sbin/ip route get 8.8.8.8 | awk '{print $NF;exit}')
echo -e "### DATE: $(date) ### \n" >> $log
echo -e "### IP: ${IP}\n\n" >> $log
echo -e "\n\n### 1.  Jupyter ###"
echo -e "jupyter server runing on http://${IP}:${JPORT}/lab \n" >> $log
jupyter lab --ip=${IP}  >> showJupyterAddress.txt &
jupyter lab ~ >> $log &
echo -e "\n\n### 2.  Rstudio ###"
echo "rstudio server running on http://${IP}:${RPORT}" >> $log
SIF="/scratch/midway2/chaodai/singularity/rstudio_R4.1.0-Rstudio2022.12.sif"
TMPDIR=/scratch/midway2/chaodai//singularity/rstudio-tmp
echo "using image $SIF" >> showRstudioAddress.txt
echo -e "---------------\n\n\n"
CONDA_PREFIX=/scratch/midway2/chaodai/miniconda3/envs/smk
R_BIN=$CONDA_PREFIX/bin/R
PY_BIN=$CONDA_PREFIX/bin/python
export SINGULARITYENV_USER=chaodai
export SINGULARITYENV_RSTUDIO_WHICH_R=${R_BIN}
export SINGULARITYENV_CONDA_PREFIX=${CONDA_PREFIX}
export SINGULARITYENV_PATH="/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/chaodai/.pyenv/shims:/opt/pyenv/bin:/home/chaodai/.local/bin:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/chaodai/bin:/home/chaodai/.local/bin:/scratch/midway2/chaodai/miniconda3/envs/smk/bin"
export SINGULARITYENV_CACHEDIR="/scratch/midway2/chaodai/singularity/singularity_cache"
RSTUDIO_SERVER_USER=chaodai # change to your own
instances=$(singularity instance list | awk 'NR > 1 {print $1}')
if [[ $instances != "" ]]; then
    singularity instance stop -a
fi
if [[ -e ~/.singularity/instances/sing ]]; then
    rm -rf ~/.singularity/instances/sing/*
fi
echo -e "\ncreate the rstudio instance: \n"
singularity instance start \
    --bind $TMPDIR/var/lib:/var/lib/rstudio-server \
    --bind $TMPDIR/var/run:/var/run/rstudio-server \
    --bind $TMPDIR/tmp:/tmp \
    --bind $TMPDIR/database.conf:/etc/rstudio/database.conf \
    --bind /sys/fs/cgroup/:/sys/fs/cgroup/:ro \
    --bind /home/chaodai:/home/rstudio \
    --bind /project2/yangili1:/project2/yangili1 \
    --bind /project2/jstaley:/project2/jstaley \
    --bind /scratch/midway2/chaodai:/scratch/midway2/chaodai \
    $SIF rstudio
echo -e "\nrun singularity exec to run rstudio server in instance rstudio\n"
PASSWORD=${MY_PASS} singularity exec \
    instance://rstudio \
    rserver --server-user=$RSTUDIO_SERVER_USER \
        --rsession-which-r=${R_BIN} \
        --www-port=${RPORT} \
        --auth-none=0 \
        --auth-pam-helper-path=pam-helper \
        --auth-timeout-minutes=0 \
        --auth-stay-signed-in-days=30 \
        --secure-cookie-key-file=/home/chaodai/rstudio-server/secure-cookie-key &
sleep 30
echo -e "\n\n### 3. code-server ###\n" >> showRstudioAddress.txt
echo "code-server runing on http://${IP}:${CPORT}" >> showRstudioAddress.txt
code-server igv
