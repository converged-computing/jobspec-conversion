#!/bin/bash
#SBATCH --job-name=flex
#SBATCH --account=brooks
#SBATCH --output=slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=05:00:00
#SBATCH --partition=gpu2080

module load pycharmm/0.5
python standard.py
