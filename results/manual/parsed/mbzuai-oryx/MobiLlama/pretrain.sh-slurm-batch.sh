#!/bin/bash
#SBATCH --job-name=mobillama
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --gres=gpu:8
#SBATCH --time=3-00:00:00
#SBATCH --partition=<partition>
#SBATCH --constraint=ntasks-per-node=8

srun python main_mobillama.py --n_nodes 20 --run_wandb
