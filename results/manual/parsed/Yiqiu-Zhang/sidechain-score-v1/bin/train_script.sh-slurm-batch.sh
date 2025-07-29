#!/bin/bash
#SBATCH --job-name=GraphIPA
#SBATCH --output=out_GraphIPA.log
#SBATCH --error=error_GraphIPA.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --constraint=ntasks-per-node=8

export NCCL_IB_DISABLE='1'
export NCCL_IB_HCA='mlx5_0 '
export NCCL_SOCKET_IFNAME='eth0'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_IB_DISABLE=1
export NCCL_IB_HCA=mlx5_0 
export NCCL_SOCKET_IFNAME=eth0
export CUDA_LAUNCH_BLOCKING=1
srun --kill-on-bad-exit=1 python3 train.py /mnt/petrelfs/zhangyiqiu/sidechain-score-v1/config_jsons/train.json --ndevice 8 --node 1 -o result_GraphIPA
