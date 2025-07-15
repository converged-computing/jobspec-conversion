#!/bin/bash
#FLUX: --job-name=clr_torch
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=16
#FLUX: --queue=disc
#FLUX: -t=172800
#FLUX: --urgency=16

export LSCRATCH='/lscratch/15937969'
export LOGLEVEL='INFO'
export NCCL_DEBUG='INFO'
export OMP_NUM_THREADS='16'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
export LSCRATCH=/lscratch/15937969
export LOGLEVEL=INFO
export NCCL_DEBUG=INFO
export OMP_NUM_THREADS=16
echo Node IP: $head_node_ip
. /home/fagg/tf_setup.sh
conda activate torch
srun torchrun \
--nnodes $SLURM_JOB_NUM_NODES \
--nproc_per_node $SLURM_NTASKS \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint "$head_node_ip:64425" \
mp.py
