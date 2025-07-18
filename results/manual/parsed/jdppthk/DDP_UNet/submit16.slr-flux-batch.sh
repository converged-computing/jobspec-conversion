#!/bin/bash
#FLUX: --job-name=carnivorous-nalgas-4716
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
worker_num=$(($SLURM_JOB_NUM_NODES - 1))
master_node=${nodes_array[0]}
for ((  i=0; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  srun --nodes=1 --ntasks=1 -w $node_i python -m torch.distributed.launch --nproc_per_node=8 --nnodes=8 --node_rank=$i --master_addr=$master_node train.py --run_num=13 &
  pids[${i}]=$!
  echo "Training started on node $i"
done
for pid in ${pids[*]}; do
    wait $pid
done
date
