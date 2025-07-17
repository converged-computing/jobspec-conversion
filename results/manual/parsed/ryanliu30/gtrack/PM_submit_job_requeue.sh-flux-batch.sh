#!/bin/bash
#FLUX: --job-name=GTrack-train
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=21600
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

mkdir -p logs
eval "$(conda shell.bash hook)"
source activate gtrack
export SLURM_CPU_BIND="cores"
echo -e "\nStarting training\n"
srun -u python run.py $@
