#!/bin/bash
#SBATCH --job-name=raw
#SBATCH --output=logs_raw/%j.out
#SBATCH --error=logs_raw/%j.err
#SBATCH --mail-user=elegyhunter@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=24
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:32g:6
#SBATCH --mem=200GB
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=1

export GPUS_PER_NODE='6'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='8000'
export WANDB_MODE='disabled'
export LOGLEVEL='INFO'
export NCCL_DEBUG='INFO'
export NCCL_BLOCKING_WAIT='1'
export TORCH_DISTRIBUTED_DETAIL='DEBUG'

source ~/.bashrc_bk
eval "$(conda shell.bash hook)"
conda activate ego
export GPUS_PER_NODE=6
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=8000
export WANDB_MODE=disabled
echo "GPUS_PER_NODE: $GPUS_PER_NODE"
echo "SLURM_NNODES: $SLURM_NNODES"
echo "SLURM_NODEID: $SLURM_NODEID"
echo "MASTER_ADDR: $MASTER_ADDR"
echo "MASTER_PORT: $MASTER_PORT"
export LOGLEVEL=INFO
export NCCL_DEBUG=INFO
export NCCL_BLOCKING_WAIT=1
export TORCH_DISTRIBUTED_DETAIL=DEBUG
srun bash -c 'torchrun \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $SLURM_NNODES \
    --node_rank $SLURM_PROCID \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT \
    train_rtx.py \
    --batch_size 2 \
    --lr 7e-5 \
    --save_id 1 \
    --image_size 64 \
    --H 8 \
    --job_name raw'
