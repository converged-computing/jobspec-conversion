#!/bin/bash
#FLUX: --job-name=ddp-torch
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=300
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$SLURM_NPROCS'
export MASTER_ADDR='$master_addr'

export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
echo "MASTER_PORT="$MASTER_PORT
export WORLD_SIZE=$SLURM_NPROCS
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source $STORE/mypython/bin/deactivate
source $STORE/mypython/bin/activate
srun ./mnist_classify_ddp.sh
