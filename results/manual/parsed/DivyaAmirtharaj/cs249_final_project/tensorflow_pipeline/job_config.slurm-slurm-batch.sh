#!/bin/bash
#SBATCH --output=./%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64000
#SBATCH --time=12:00:00
#SBATCH --partition=seas_gpu

source venv/bin/activate
python model_training.py
