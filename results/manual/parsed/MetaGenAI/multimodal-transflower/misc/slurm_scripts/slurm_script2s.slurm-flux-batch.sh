#!/bin/bash
#FLUX: --job-name=nerdy-chip-0541
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: -t=72000
#FLUX: --urgency=16

export MASTER_PORT='1234'
export MASTER_ADDRESS='$(echo $slurm_nodes | cut -d' ' -f1)'

export MASTER_PORT=1234
slurm_nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
echo $slurm_nodes
export MASTER_ADDRESS=$(echo $slurm_nodes | cut -d' ' -f1)
echo $MASTER_ADDRESS
module load pytorch-gpu/py3/1.8.0
srun ./script_train.sh $@
