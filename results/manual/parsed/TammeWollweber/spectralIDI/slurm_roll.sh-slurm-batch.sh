#!/bin/bash
#SBATCH --job-name=roll
#SBATCH --output=.%j.out
#SBATCH --error=.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpu-ayyer
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=mpsd-hpc-gpu-003

srun python roll_mem.py 
