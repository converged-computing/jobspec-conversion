#!/bin/bash
#FLUX: --job-name=Nano-2d-trainer-20b-8nodes
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --gpus-per-task=4
#FLUX: --queue=train
#FLUX: --priority=16

export FI_PROVIDER='efa'
export LOGLEVEL='INFO'
export NCCL_DEBUG='WARN'
export NCCL_DEBUG_SUBSYS='WARN'
export PYTHONFAULTHANDLER='1'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'
export CUDA_LAUNCH_BLOCKING='0'
export NCCL_SOCKET_IFNAME='ens'
export FI_EFA_USE_DEVICE_RDMA='1'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
export FI_PROVIDER="efa"
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
export NCCL_DEBUG=WARN
export NCCL_DEBUG_SUBSYS=WARN
export PYTHONFAULTHANDLER=1
export LD_LIBRARY_PATH=/opt/amazon/efa/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export CUDA_LAUNCH_BLOCKING=0
export NCCL_SOCKET_IFNAME="ens"
export FI_EFA_USE_DEVICE_RDMA=1
srun  torchrun --nproc_per_node 4 --rdzv_id $RANDOM --rdzv_backend c10d --rdzv_endpoint $head_node_ip:29500 llama_finetuning.py  --enable_fsdp --use_peft --peft_method lora
