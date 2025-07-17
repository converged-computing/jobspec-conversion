#!/bin/bash
#FLUX: --job-name=evasive-earthworm-2472
#FLUX: -N=2
#FLUX: -c=80
#FLUX: --gpus-per-task=8
#FLUX: -t=1800
#FLUX: --urgency=16

nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
master_node=${nodes_array[0]}
master_addr=$(srun --nodes=1 --ntasks=1 -w $master_node hostname --ip-address)
worker_num=$(($SLURM_JOB_NUM_NODES))
for ((  node_rank=0; node_rank<$worker_num; node_rank++ ))
do
  node=${nodes_array[$node_rank]}
  echo "Initializing node # $node_rank, $node"
  srun --nodes=1 --ntasks=1 -w $node shifter --env HDF5_USE_FILE_LOCKING=FALSE --env NCCL_IB_DISABLE=0 --env NCCL_IB_HCA=mlx5_0:1,mlx5_2:1,mlx5_4:1,mlx5_6:1 \
  python -m torch.distributed.launch --nproc_per_node=8 --nnodes=$SLURM_JOB_NUM_NODES --node_rank=$node_rank --master_addr=$master_addr \
  train.py --config=baseline &
  pids[${node_rank}]=$!
done
for pid in ${pids[*]}; do
    wait $pid
done
