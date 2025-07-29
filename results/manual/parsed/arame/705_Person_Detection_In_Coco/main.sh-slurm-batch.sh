#!/bin/bash
#SBATCH --job-name=Geoff P
#SBATCH --output=job%J.output
#SBATCH --error=jo%J.err
#SBATCH --mail-user=geoffrey.payne@city.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:
#SBATCH --constraint=ntasks-per-node=8

module load python/3.6.12
python main.py
