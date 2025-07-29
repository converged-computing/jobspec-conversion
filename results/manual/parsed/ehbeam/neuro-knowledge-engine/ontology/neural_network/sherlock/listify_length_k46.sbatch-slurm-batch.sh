#!/bin/bash
#SBATCH --job-name=k46_listlen
#SBATCH --output=logs/k46_listlen.%j.out
#SBATCH --error=logs/k46_listlen.%j.err
#SBATCH --mail-user=ebeam@stanford.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=aetkin

module load python/3.6 py-pytorch/1.0.0_py36
srun python3 listify_length_k46.py
