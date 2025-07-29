#!/bin/bash
#SBATCH --job-name=ivae-gpu
#SBATCH --output=slurm_log/ivae-gpu.%A_%a.out
#SBATCH --error=slurm_log/ivae-gpu.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:06:00

module add nvidia/9.0
source ~/.bashrc
conda activate deep
python main.py $(sed -n ${SLURM_ARRAY_TASK_ID}p args_gpu_seeded.txt)
