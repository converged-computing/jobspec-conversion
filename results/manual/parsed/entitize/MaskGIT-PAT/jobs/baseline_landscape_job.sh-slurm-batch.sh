#!/bin/bash
#SBATCH --job-name=baseline_landscape_job
#SBATCH --account=mlprojects
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=5G
#SBATCH --time=3-00:00:00

source ~/.bashrc
module load cuda/11.8
cd ~/MaskGIT-PAT
python training_vqgan.py \
    --dataset-path /groups/mlprojects/pat/landscape/ \
    --batch-size 4 \
    --experiment-name baseline_landscape_3days \
    --save-img-rate 1000 \
    --epochs 1000
