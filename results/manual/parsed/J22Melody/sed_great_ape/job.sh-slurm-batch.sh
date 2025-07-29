#!/bin/bash
#SBATCH --job-name=baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000M
#SBATCH --time=2-00:00:00

module load cudnn/7.6.5.32-10.2
module load anaconda3
source activate audio_clf
CUBLAS_WORKSPACE_CONFIG=:4096:8 stdbuf -o0 -e0 srun --unbuffered python model.py -c $1
