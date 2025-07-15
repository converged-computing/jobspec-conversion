#!/bin/bash
#FLUX: --job-name=graphIPA_M
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --priority=16

export NCCL_IB_DISABLE='1'
export NCCL_IB_HCA='mlx5_0 '
export NCCL_SOCKET_IFNAME='eth0'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_IB_DISABLE=1
export NCCL_IB_HCA=mlx5_0 
export NCCL_SOCKET_IFNAME=eth0
export CUDA_LAUNCH_BLOCKING=1
srun --kill-on-bad-exit=1 python3 train.py /mnt/petrelfs/zhangyiqiu/sidechain-score-v1/config_jsons/graphIPA_M.json --ndevice 8 --node 2 -o result_graphIPA_m
