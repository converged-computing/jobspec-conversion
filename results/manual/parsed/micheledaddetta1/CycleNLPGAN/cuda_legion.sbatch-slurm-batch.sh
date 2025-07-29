#!/bin/bash
#SBATCH --job-name=trainingCycleGAN
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=48GB
#SBATCH --time=9-14:00:00
#SBATCH --partition=cuda

module load nvidia/cudasdk/10.0
python train.py
