#!/bin/bash
#SBATCH --job-name=GSI-WRF-Cycling-Template
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00

python -u rocoto_utilities.py
