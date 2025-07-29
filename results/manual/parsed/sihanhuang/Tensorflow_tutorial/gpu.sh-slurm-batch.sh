#!/bin/bash
#SBATCH --job-name=HelloWorld
#SBATCH --account=stats
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1gb
#SBATCH --time=00:01:00

module load cuda80/toolkit
module load gcc
module load anaconda
python Hello.py
