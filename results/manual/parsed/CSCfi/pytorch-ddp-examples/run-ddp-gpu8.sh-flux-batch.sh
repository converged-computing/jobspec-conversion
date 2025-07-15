#!/bin/bash
#FLUX: --job-name=stanky-lemur-1788
#FLUX: -N=2
#FLUX: -c=40
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export RDZV_HOST='$(hostname)'
export RDZV_PORT='29400                   '

module purge
module load pytorch
export RDZV_HOST=$(hostname)
export RDZV_PORT=29400                   
srun torchrun \
    --nnodes=$SLURM_JOB_NUM_NODES \
    --nproc_per_node=4 \
    --rdzv_id=$SLURM_JOB_ID \
    --rdzv_backend=c10d \
    --rdzv_endpoint="$RDZV_HOST:$RDZV_PORT" \
    mnist_ddp.py --epochs=100
