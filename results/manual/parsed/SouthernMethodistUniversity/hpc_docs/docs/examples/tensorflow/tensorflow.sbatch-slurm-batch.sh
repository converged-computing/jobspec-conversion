#!/bin/bash
#SBATCH --job-name=tensorflow
#SBATCH --output=tensorflow_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6G
#SBATCH --time=00:01:00

module purge
module load tensorflow
python3 example.py
