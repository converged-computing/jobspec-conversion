#!/bin/bash
#SBATCH --job-name=debug
#SBATCH --output=logs/run-%j-debug.out
#SBATCH --error=logs/run-%j-debug.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --constraint=ntasks-per-node=1

python \
-m torch.distributed.launch \
--nproc_per_node=8 \
--nnodes=1 \
--node_rank=0 \
train.py \
--from_pretrained data/models/pytorch_model_9.bin \
--save_name testing \
--num_workers 0 \
--debug
