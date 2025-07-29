#!/bin/bash
#SBATCH --job-name=GA
#SBATCH --account=C3SE2021-1-15
#SBATCH --output=stdout
#SBATCH --error=stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=hebbe

module purge
module load intel/2019a GPAW ASE
mpirun gpaw-python ga.py
