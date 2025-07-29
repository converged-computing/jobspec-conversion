#!/bin/bash
#SBATCH --job-name=graphIPA_M
#SBATCH --output=out_graphIPA_M.log
#SBATCH --error=error_graphIPA_M.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --partition=bio_s1
#SBATCH --constraint=ntasks-per-node=8

export NCCL_IB_DISABLE='1'
export NCCL_IB_HCA='mlx5_0 '
export NCCL_SOCKET_IFNAME='eth0'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_IB_DISABLE=1
export NCCL_IB_HCA=mlx5_0 
export NCCL_SOCKET_IFNAME=eth0
export CUDA_LAUNCH_BLOCKING=1
srun --kill-on-bad-exit=1 python3 train.py /mnt/petrelfs/zhangyiqiu/sidechain-score-v1/config_jsons/graphIPA_M.json --ndevice 8 --node 2 -o result_graphIPA_m
