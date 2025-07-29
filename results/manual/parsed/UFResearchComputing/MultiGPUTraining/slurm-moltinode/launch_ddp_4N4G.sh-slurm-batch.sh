#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=24gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=hpg-ai
#SBATCH --constraint=ntasks-per-node=1

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
