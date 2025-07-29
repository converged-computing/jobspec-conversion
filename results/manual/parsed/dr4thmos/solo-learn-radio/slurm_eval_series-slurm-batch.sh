#!/bin/bash
#SBATCH --account=IscrC_RaConSSL
#SBATCH --output=eval_%j.out
#SBATCH --error=eval_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export MASTER_ADDR='$master_addr'
export WORLD_SIZE='$((GPUS_PER_NODE * SLURM_NNODES))'

GPUS_PER_NODE=1
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
echo "SLURM_NTASKS="$SLURM_NTASKS
NTASKS_PER_NODE=$((SLURM_NTASKS / SLURM_JOB_NUM_NODES))
echo "NTASKS_PER_NODE="$NTASKS_PER_NODE
export WORLD_SIZE=$((GPUS_PER_NODE * SLURM_NNODES))
echo "WORLD_SIZE=$WORLD_SIZE"
MASTER_PORT=11111
module load cuda cudnn nccl openmpi 
source /leonardo_scratch/large/userexternal/tceccone/solovenv/bin/activate
sh experiments.sh
