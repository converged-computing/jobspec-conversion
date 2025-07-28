#!/bin/bash
#FLUX: --job-name=ddp-torch
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export MASTER_ADDR='$master_addr'

export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "WORLD_SIZE="$WORLD_SIZE
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
module purge
module load singularity/3.1.0
nvidia-smi
extra_opt="--optimizer-option lr_mult (\"fc.*\",50)"
srun singularity exec --nv ~/weaver.sif python -u top_tagging.py \
    --batch_size=128 --epochs=20 \
    --optimizer-option weight_decay 0.01 \
    --start_lr 1e-4 --optimizer ranger --use_amp \
    ${extra_opt}
