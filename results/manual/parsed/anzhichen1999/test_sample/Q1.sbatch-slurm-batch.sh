#!/bin/bash
#SBATCH --job-name=Q1
#SBATCH --account=macs30113
#SBATCH --output=Q1.out
#SBATCH --nodes=10
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=30G
#SBATCH --time=00:10:00
#SBATCH --partition=broadwl

module load python 
module load cuda
python finished.py
