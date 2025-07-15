#!/bin/bash
#FLUX: --job-name=fugly-peanut-0347
#FLUX: -c=16
#FLUX: --gpus-per-task=8
#FLUX: --queue=hpg-ai
#FLUX: -t=172800
#FLUX: --urgency=16

export NCCL_DEBUG='WARN #change to INFO if debugging DDP'
export LOGLEVEL='INFO'

export NCCL_DEBUG=WARN #change to INFO if debugging DDP
pwd;date;hostname
module load conda
conda activate torch-timm
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
srun --export=ALL torchrun \
--nnodes 1 \
--nproc_per_node 1 \
--nproc_per_node=$SLURM_GPUS_PER_TASK \
multigpu_torchrun.py 50 10
