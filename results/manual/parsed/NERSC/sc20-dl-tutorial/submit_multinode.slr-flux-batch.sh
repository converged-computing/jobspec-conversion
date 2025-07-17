#!/bin/bash
#FLUX: --job-name=lovely-truffle-1961
#FLUX: -N=2
#FLUX: -c=80
#FLUX: --gpus-per-task=8
#FLUX: -t=1800
#FLUX: --urgency=16

nproc_per_node=8
config=bs2048-warmup-opt
module load cgpu
module load pytorch/1.7.0-gpu
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
master_node=${nodes_array[0]}
master_addr=$(srun --nodes=1 --ntasks=1 -w $master_node hostname --ip-address)
worker_num=$(($SLURM_JOB_NUM_NODES))
for ((  node_rank=0; node_rank<$worker_num; node_rank++ ))
do
  node=${nodes_array[$node_rank]}
  echo "Submitting node # $node_rank, $node"
  # Launch one SLURM task per node, and use torch distributed launch utility
  # to spawn training worker processes; one per GPU
  srun -N 1 -n 1 -w $node python -m torch.distributed.launch \
    --nproc_per_node=$nproc_per_node --nnodes=$SLURM_JOB_NUM_NODES \
    --node_rank=$node_rank --master_addr=$master_addr \
    train.py --config=$config &
  pids[${node_rank}]=$!
done
for pid in ${pids[*]}; do
    wait $pid
done
