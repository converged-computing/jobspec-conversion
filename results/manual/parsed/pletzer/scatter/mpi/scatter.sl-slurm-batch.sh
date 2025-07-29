#!/bin/bash
#SBATCH --job-name=scatter
#SBATCH --output=scatter-%j.output
#SBATCH --error=scatter-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

srun time python scatter.py -checksum
