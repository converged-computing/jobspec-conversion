#!/bin/bash
#FLUX: --job-name=rainbow-plant-6911
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: -t=600
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
