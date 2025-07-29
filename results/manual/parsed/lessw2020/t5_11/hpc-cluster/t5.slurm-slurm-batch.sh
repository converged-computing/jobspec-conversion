#!/bin/bash
#FLUX: --job-name=T5-trainer
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --gpus-per-task=8
#FLUX: --urgency=16

export LOGLEVEL='INFO'
export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='ALL'
export PYTHONFAULTHANDLER='1'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'
export NCCL_SOCKET_IFNAME='en,eth,em,bond'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=ALL
export PYTHONFAULTHANDLER=1
export LD_LIBRARY_PATH=/opt/amazon/efa/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export NCCL_SOCKET_IFNAME="en,eth,em,bond"
dcgmi profile --pause
srun --prolog job_prolog.sh --epilog job_epilog.sh /usr/local/cuda/bin/nsys profile -t cuda,nvtx -s none -x true python -m torch.distributed.run --nproc_per_node 8 --rdzv_id $RANDOM --rdzv_backend c10d --rdzv_endpoint $head_node_ip:29500 ./main_torchrun.py
dcgmi profile --resume
