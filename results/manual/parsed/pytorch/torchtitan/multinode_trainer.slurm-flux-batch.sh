#!/bin/bash
#FLUX: --job-name=torchtitan_multi_node
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=96
#FLUX: --gpus-per-task=8
#FLUX: --queue=train
#FLUX: --priority=16

export LOGLEVEL='INFO'
export FI_PROVIDER='efa'
export NCCL_IB_DISABLE='1'
export NCCL_DEBUG='WARN'
export PYTHONFAULTHANDLER='1'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'
export CUDA_LAUNCH_BLOCKING='0'
export NCCL_SOCKET_IFNAME='eth0,en,eth,em,bond'
export NCCL_BUFFSIZE='2097152'
export FI_EFA_SET_CUDA_SYNC_MEMOPS='0'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
export FI_PROVIDER="efa"
export NCCL_IB_DISABLE=1
export NCCL_DEBUG=WARN
export PYTHONFAULTHANDLER=1
export LD_LIBRARY_PATH=/opt/amazon/efa/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export CUDA_LAUNCH_BLOCKING=0
export NCCL_SOCKET_IFNAME="eth0,en,eth,em,bond"
export NCCL_BUFFSIZE=2097152
export FI_EFA_SET_CUDA_SYNC_MEMOPS=0
CONFIG_FILE=${CONFIG_FILE:-"./train_configs/llama2_13b.toml"}
dcgmi profile --pause
srun torchrun --nnodes 4 --nproc_per_node 8 --rdzv_id 101 --rdzv_backend c10d --rdzv_endpoint "$head_node_ip:29500" ./train.py --job.config_file ${CONFIG_FILE}
dcgmi profile --resume
