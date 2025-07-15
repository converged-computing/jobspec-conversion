#!/bin/bash
#FLUX: --job-name=ndt2_4x_4
#FLUX: -N=4
#FLUX: -c=6
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1'
export SLURM_NTASKS_PER_NODE='4'

export NCCL_IB_DISABLE=1
echo 'tasks'
echo $SLURM_NTASKS
echo 'per node'
export SLURM_NTASKS_PER_NODE=4
echo $SLURM_NTASKS_PER_NODE
hostname
source ~/.bashrc # Note bashrc has been modified to allow slurm jobs
source ~/load_env.sh
srun python -u run.py nodes=4 $1
