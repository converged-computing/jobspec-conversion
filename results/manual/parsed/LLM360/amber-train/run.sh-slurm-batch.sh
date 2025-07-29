#!/bin/bash
#SBATCH --job-name=amber-7b
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --nodes=56
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --partition=gpumid
#SBATCH --constraint=ntasks-per-node=4

srun python main.py --n_nodes 56 --run_wandb
