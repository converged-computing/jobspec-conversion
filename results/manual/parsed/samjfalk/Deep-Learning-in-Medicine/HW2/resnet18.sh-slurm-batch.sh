#!/bin/bash
#SBATCH --job-name=resnet18
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64GB
#SBATCH --time=05:00:00

module purge
source activate /home/sjf374/dl4med
srun python resnet18.py
