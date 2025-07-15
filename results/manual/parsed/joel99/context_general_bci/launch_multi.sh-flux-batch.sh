#!/bin/bash
#FLUX: --job-name=ndt2_4x
#FLUX: -c=6
#FLUX: --priority=16

export SLURM_NTASKS_PER_NODE='4'

echo 'tasks'
echo $SLURM_NTASKS
echo 'per node'
export SLURM_NTASKS_PER_NODE=4
echo $SLURM_NTASKS_PER_NODE
hostname
source ~/.bashrc # Note bashrc has been modified to allow slurm jobs
source ~/load_env.sh
srun python -u run.py $1
