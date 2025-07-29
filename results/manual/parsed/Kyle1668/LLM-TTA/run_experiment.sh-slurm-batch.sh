#!/bin/bash
#SBATCH --job-name=TTA
#SBATCH --output=slurm_logs/run_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a6000:8
#SBATCH --mem=250GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1

export NCCL_DEBUG='INFO'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_DEBUG=INFO
export CUDA_LAUNCH_BLOCKING=1
source activate llm-tta
experiment_make=$1
seed=$2
make $experiment_make SEED=$seed
