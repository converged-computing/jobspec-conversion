#!/bin/bash
#SBATCH --job-name=autoencoder
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=0
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python/tensorflow-2.3.1
module load cuda
python3 train_autoencoder.py
