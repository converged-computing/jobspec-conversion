#!/bin/bash

#SBATCH --job-name=k46_listlen
#SBATCH --output=logs/k46_listlen.%j.out
#SBATCH --error=logs/k46_listlen.%j.err
#SBATCH --time=02-00:00:00
#SBATCH -p aetkin
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=ebeam@stanford.edu

module load python/3.6 py-pytorch/1.0.0_py36
srun python3 listify_length_k46.py
