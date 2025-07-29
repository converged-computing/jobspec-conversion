#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=24gb
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='WARN #change to INFO if debugging DDP'
export LOGLEVEL='INFO'

export NCCL_DEBUG=WARN #change to INFO if debugging DDP
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
module load conda
conda activate pytorch_lightning
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
pwd; hostname; date
srun --export=ALL torchrun \
--nnodes 4 \
--nproc_per_node 1 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:29500 \
multigpu_torchrun.py 50 10
