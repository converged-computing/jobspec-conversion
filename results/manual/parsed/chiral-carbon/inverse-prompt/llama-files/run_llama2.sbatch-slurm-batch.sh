#!/bin/bash
#FLUX: --job-name=run_llama2
#FLUX: -N=2
#FLUX: -t=87120
#FLUX: --urgency=16

export LOGLEVEL='INFO'
export NCCL_DEBUG='WARN'
export NCCL_DEBUG_SUBSYS='WARN'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'

source ~/.bashrc
conda activate /scratch/ad6489/.conda/envs/penv
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(ssh $head_node "hostname --ip-address")
head_node_port=$(ssh $head_node "/home/as17582/get_free_port.sh")
rdzv_id=$RANDOM
echo Node IP: $head_node_ip
echo Node port: $head_node_port
export LOGLEVEL=INFO
export NCCL_DEBUG=WARN
export NCCL_DEBUG_SUBSYS=WARN
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
srun --nodes=2 --ntasks-per-node=4 ./run_test_llama2.sh $rdzv_id $head_node_ip $head_node_port $SLURM_NTASKS
