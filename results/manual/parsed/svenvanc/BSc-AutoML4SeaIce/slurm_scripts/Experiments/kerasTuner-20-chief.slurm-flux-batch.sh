#!/bin/bash
#FLUX: --job-name=kerasTuner_chief_r2_experiment
#FLUX: --queue=cpu-long
#FLUX: -t=604800
#FLUX: --urgency=16

export ENV='/home/s2358093/data1/conda_envs/hvm-05'
export CWD='$(pwd)'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$TENSORRT_PATH/'
export KERASTUNER_TUNER_ID='chief'
export KERASTUNER_ORACLE_IP='${IP}'
export KERASTUNER_ORACLE_PORT='${CHIEF_PORT_NR}'
export PARENT_JOB_ID='${SLURM_JOB_ID}'

cd /home/s2358093/AutoML4SeaIce
export ENV=/home/s2358093/data1/conda_envs/hvm-05
echo "[$SHELL] #### Starting Python test"
echo "[$SHELL] ## This is $SLURM_JOB_USER and this job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] ## current working directory: "$CWD
__conda_setup="$('/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/etc/profile.d/conda.sh" ]; then
        . "/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/etc/profile.d/conda.sh"
    else
        export PATH="/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate ${ENV}
echo "[$SHELL] ## ***** conda env activated *****"
echo "conda prefix: $CONDA_PREFIX"
TENSORRT_PATH=$CONDA_PREFIX/lib/python3.10/site-packages/tensorrt
echo "TENSORRT_PATH: $TENSORRT_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$TENSORRT_PATH/
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
conda info
IP=$(hostname -I | awk '{print $1}')
echo "IP:  ${IP}"
echo "port_nr:  ${CHIEF_PORT_NR}"
export KERASTUNER_TUNER_ID=chief
export KERASTUNER_ORACLE_IP=${IP}
export KERASTUNER_ORACLE_PORT=${CHIEF_PORT_NR}
export PARENT_JOB_ID=${SLURM_JOB_ID}
echo "export KERASTUNER_ORACLE_IP=${IP}" > TUNER_ADDRESS_${SLURM_JOB_ID}.sh
echo "export KERASTUNER_ORACLE_PORT=${CHIEF_PORT_NR}" >> TUNER_ADDRESS_${SLURM_JOB_ID}.sh
sbatch --export=PARENT_JOB_ID=${SLURM_JOB_ID} kerasTuner-20-worker.slurm
python kerasTuner-20-a.py
echo "[$SHELL] Script finished"
