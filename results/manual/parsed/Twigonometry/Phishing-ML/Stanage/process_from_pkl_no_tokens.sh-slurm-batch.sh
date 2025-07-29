#!/bin/bash
#SBATCH --job-name=process_from_pkl_no_tokens
#SBATCH --output=process_from_pkl_no_tokens.log
#SBATCH --mail-user=$EMAIL
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --qos=gpu

export TRANSFORMERS_CACHE='/mnt/parscratch/users/$USERNAME/cache'

module load Anaconda3/2022.10
module load cuDNN/8.8.0.121-CUDA-12.0.0
nvcc --version
nvidia-smi
source /opt/apps/testapps/common/software/staging/Anaconda3/2022.10/bin/activate
conda activate pytorch
export TRANSFORMERS_CACHE=/mnt/parscratch/users/$USERNAME/cache
python process_from_pkl_no_tokens.py
