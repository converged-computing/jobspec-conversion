#!/bin/bash
#FLUX: --job-name=quirky-cinnamonbun-5950
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=4
#FLUX: --gpus-per-task=2
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
--nnodes 2 \
--nproc_per_node 2 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:$head_node_port \
multigpu_torchrun.py 50 10
