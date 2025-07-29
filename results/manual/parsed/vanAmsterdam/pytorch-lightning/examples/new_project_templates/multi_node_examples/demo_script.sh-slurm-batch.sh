#!/bin/bash
#SBATCH --job-name=lightning_test
#SBATCH --output=/slurm_output_%j.out
#SBATCH --error=/slurm_output_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export MASTER_PORT='$((12000 + RANDOM % 20000))$'

source activate YourEnv
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME=^docker0,lo
module load NCCL/2.4.7-1-cuda.10.0
export MASTER_PORT=$((12000 + RANDOM % 20000))$
srun python multi_node_own_slurm_script.py
