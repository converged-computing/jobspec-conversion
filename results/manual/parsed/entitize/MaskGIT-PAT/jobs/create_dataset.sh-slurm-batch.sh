#!/bin/bash
#SBATCH --job-name=pat_cnn_dataset_norm
#SBATCH --account=mlprojects
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=5G
#SBATCH --time=01:00:00

export CUDA_VISIBLE_DEVICES='0'

source ~/.bashrc
module load cuda/11.8
module load gcc/9.2.0
module load clang/16.0.4
export CUDA_VISIBLE_DEVICES=0
cd ~/MaskGIT-PAT
python create_cnn_dataset.py
    # --experiment-name cnn_inpainting_check_versions \
