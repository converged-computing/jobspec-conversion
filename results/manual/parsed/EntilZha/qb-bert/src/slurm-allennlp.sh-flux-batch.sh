#!/bin/bash
#FLUX: --job-name=qb-bert
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: --urgency=16

export SLURM_LOG_FILE='/fs/clip-quiz/entilzha/logs/${SLURM_JOB_ID}.log'
export MODEL_CONFIG_FILE='$2'

set -x
hostname
nvidia-smi
source /fs/clip-quiz/entilzha/anaconda3/etc/profile.d/conda.sh > /dev/null 2> /dev/null
conda activate qb-bert
export SLURM_LOG_FILE="/fs/clip-quiz/entilzha/logs/${SLURM_JOB_ID}.log"
export MODEL_CONFIG_FILE="$2"
cd $1
pwd
srun python qb/main.py train $2
