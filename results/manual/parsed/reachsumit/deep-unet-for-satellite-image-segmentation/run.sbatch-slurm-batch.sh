#!/bin/bash
#SBATCH --job-name=satellite
#SBATCH --account=mscagpu
#SBATCH --output=logout_%j.txt
#SBATCH --error=logerr_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=03:00:00
#SBATCH --partition=mscagpu

module load Anaconda3 cuda/8.0
python train_unet.py
python predict.py
