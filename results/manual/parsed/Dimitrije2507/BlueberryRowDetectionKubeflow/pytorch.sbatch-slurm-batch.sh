#!/bin/bash
#SBATCH --job-name=torch
#SBATCH --output=slurm.%J.out
#SBATCH --error=slurm.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=21-18:00:00
#SBATCH --partition=main

srun bash child.sh
