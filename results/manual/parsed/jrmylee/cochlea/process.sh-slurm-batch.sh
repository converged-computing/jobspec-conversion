#!/bin/bash
#SBATCH --job-name=daniil
#SBATCH --account=fc_deepmusic
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

module load pytorch/1.0.0-py36-cuda9.0 libsndfile
python -u main.py
