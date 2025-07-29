#!/bin/bash
#SBATCH --output=storage/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=20:00:00
#SBATCH --partition=long
#SBATCH --exclude=rtx3,rtx5

module load anaconda
conda activate conda_env
python test14.py 
