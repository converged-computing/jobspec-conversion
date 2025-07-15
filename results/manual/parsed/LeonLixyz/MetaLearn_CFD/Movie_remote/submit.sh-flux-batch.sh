#!/bin/bash
#FLUX: --job-name=Movie_experiments_name
#FLUX: -t=432000
#FLUX: --urgency=16

[[ ! -d slurm ]] && mkdir slurm
experiment_name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" experiments.txt)
echo Queueing experiment $experiment_name
source ~/.bashrc
conda activate pytorch_env
srun python Main.py $experiment_name
conda deactivate
