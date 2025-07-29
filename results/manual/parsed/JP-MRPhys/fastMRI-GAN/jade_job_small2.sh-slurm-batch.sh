#!/bin/bash
#SBATCH --job-name=vqvae
#SBATCH --mail-user=jehill.parikh@newcastle.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load python3/anaconda
source activate tensorflow2-gpu
python ./model/VQVAE1.py
