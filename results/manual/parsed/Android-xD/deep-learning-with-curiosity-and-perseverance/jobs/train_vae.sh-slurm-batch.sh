#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=./logs/train_vae.out
#SBATCH --error=./logs/train_vae.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=1-00:00:00

source scripts/startup.sh
cd src/training
python train_variational_autoencoder.py
