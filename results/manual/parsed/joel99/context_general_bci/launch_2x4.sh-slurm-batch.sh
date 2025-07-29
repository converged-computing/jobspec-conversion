#!/bin/bash
#SBATCH --job-name=ndt2_2x_4
#SBATCH --output=slurm_logs/%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=90G
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4

export NCCL_IB_DISABLE='1'
export SLURM_NTASKS_PER_NODE='4'

export NCCL_IB_DISABLE=1
echo 'tasks'
echo $SLURM_NTASKS
echo 'per node'
export SLURM_NTASKS_PER_NODE=4
echo $SLURM_NTASKS_PER_NODE
hostname
source ~/.bashrc # Note bashrc has been modified to allow slurm jobs
source ~/load_env.sh
srun python -u run.py nodes=2 $1
