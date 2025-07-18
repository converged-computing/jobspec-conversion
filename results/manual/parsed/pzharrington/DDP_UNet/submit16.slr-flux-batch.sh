#!/bin/bash
#FLUX: --job-name=pusheena-dog-9736
#FLUX: -N=2
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

module load pytorch/v1.4.0-gpu
module list
export HDF5_USE_FILE_LOCKING=FALSE
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
master_node=${nodes_array[0]}
master_addr=$(srun --nodes=1 --ntasks=1 -w $master_node hostname --ip-address)
worker_num=$(($SLURM_JOB_NUM_NODES - 1))
for ((  i=0; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  srun --nodes=1 --ntasks=1 -w $node_i python -m torch.distributed.launch --nproc_per_node=8 --nnodes=$SLURM_JOB_NUM_NODES --node_rank=$i --master_addr=$master_addr train.py --run_num=13 &
  pids[${i}]=$!
  echo "Training started on node $i"
done
for pid in ${pids[*]}; do
    wait $pid
done
date
