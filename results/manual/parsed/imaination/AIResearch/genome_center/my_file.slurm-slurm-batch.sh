#!/bin/bash
#SBATCH --job-name=RURIKO_TENSORFLOW
#SBATCH --output=train_network.out
#SBATCH --error=train_network.err
#SBATCH --mail-user=raimai@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --array=1-5

python train_network.py
