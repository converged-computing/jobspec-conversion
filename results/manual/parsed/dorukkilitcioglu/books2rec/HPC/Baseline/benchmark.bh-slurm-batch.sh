#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=128GB
#SBATCH --time=2-00:00:00

module purge
python3 benchmark.py
