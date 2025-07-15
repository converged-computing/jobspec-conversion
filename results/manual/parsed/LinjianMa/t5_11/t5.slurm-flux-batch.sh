#!/bin/bash
#FLUX: --job-name=T5-trainer
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=96
#FLUX: --gpus-per-task=8
#FLUX: --urgency=16

export LOGLEVEL='INFO'
export FI_PROVIDER='efa'
export NCCL_DEBUG='WARN'
export NCCL_DEBUG_SUBSYS='WARN'
export PYTHONFAULTHANDLER='1'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'
export CUDA_LAUNCH_BLOCKING='0'
export NCCL_SOCKET_IFNAME='eth0,en,eth,em,bond'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
export FI_PROVIDER="efa"
export NCCL_DEBUG=WARN
export NCCL_DEBUG_SUBSYS=WARN
export PYTHONFAULTHANDLER=1
export LD_LIBRARY_PATH=/opt/amazon/efa/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export CUDA_LAUNCH_BLOCKING=0
export NCCL_SOCKET_IFNAME="eth0,en,eth,em,bond"
dcgmi profile --pause
srun --prolog job_prolog.sh --epilog job_epilog.sh torchrun --nnodes 2 --nproc_per_node 8 --rdzv_id 101 --rdzv_backend c10d --rdzv_endpoint "$head_node_ip:29500" ./main_elastic.py
dcgmi profile --resume
