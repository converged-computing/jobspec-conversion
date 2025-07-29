#!/bin/bash
#SBATCH --job-name=SIF_SC
#SBATCH --output=logs/gpu_SIF_slide_classification.out
#SBATCH --error=logs/gpu_SIF_slide_classification.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1

echo "starting .."
echo "done"
