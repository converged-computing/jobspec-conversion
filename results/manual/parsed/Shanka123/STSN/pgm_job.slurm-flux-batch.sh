#!/bin/bash
#FLUX: --job-name=salted-cinnamonbun-0136
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=518400
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$master_addr'
export NCCL_DEBUG='INFO'

source ~/.bashrc
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
export NCCL_DEBUG=INFO
srun python train_slot_transformer_pgm_multigpu.py --img_size=80 --batch_size=16 --depth=24 --learning_rate=0.00008 --run='1' --num_epochs=160
