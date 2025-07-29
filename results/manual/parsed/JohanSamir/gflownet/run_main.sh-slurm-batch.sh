#!/bin/bash
#SBATCH --job-name=debug
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --partition=unkillable

module load python/3.9 cuda/11.7 
source ~/venvs/gflownet/bin/activate
python ~/gflownet/src/gflownet/tasks/main.py
