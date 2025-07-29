#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=kkasodek@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A6000:1
#SBATCH --mem=32G
#SBATCH --time=00:11:00

...
nvidia-smi # Useful for seeing GPU status and activity 
python train.py
...
