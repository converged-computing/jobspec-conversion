#!/bin/bash
#FLUX: --job-name=bloated-mango-5363
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=hpg-ai
#FLUX: -t=172800
#FLUX: --urgency=16

export LOGLEVEL='INFO'

module load pytorch/1.10
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
echo Node list $nodes_array
head_node_ip=`hostname --ip-address`
echo HeadNodeIP: $head_node_ip
head_node_port=29500
export LOGLEVEL=INFO
pwd; hostname; date
srun --export=ALL torchrun \
--nnodes 4 \
--nproc_per_node 1 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:$head_node_port \
multigpu_torchrun.py 50 10
