#!/bin/bash
#FLUX: --job-name=multinode-example
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export LOGLEVEL='INFO'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
srun torchrun \
--nnodes 4 \
--nproc_per_node 1 \  # corresponds to --gpus-per-task 
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:29500 \
/shared/distributed-pytorch/multinode_torchrun.py 50 10
