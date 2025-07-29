#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=./logs/create_dataset.out
#SBATCH --error=./logs/create_dataset.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=10:00:00

source scripts/startup.sh
cd src/data_preprocessing
python create_dataset.py
