#!/bin/bash
#FLUX: --job-name=strawberry-toaster-9082
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'

mkdir -p logs
eval "$(conda shell.bash hook)"
source activate gtrack
export SLURM_CPU_BIND="cores"
echo -e "\nStarting training\n"
srun -u python run.py $@
