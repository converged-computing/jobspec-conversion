#!/bin/bash
#SBATCH --job-name=unet
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=6-00:00:00
#SBATCH --qos=gpu
#SBATCH --exclude=SPG-1-[1-4]

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export FLAGS_sync_nccl_allreduce='1 # use nccl to do allreduce'
export FLAGS_enable_parallel_graph='1 # enable parallel graph mode'

source ~/.bashrc
conda activate paddle_x3.9
module load cuda
export CUDA_VISIBLE_DEVICES=0,1,2,3
'''
export FLAGS_sync_nccl_allreduce=1 # use nccl to do allreduce
export FLAGS_enable_parallel_graph=1 # enable parallel graph mode
'''
python -m paddle.distributed.launch --log_dir=output_unet unet.py
