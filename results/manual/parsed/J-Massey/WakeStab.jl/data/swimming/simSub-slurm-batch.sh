#!/bin/bash
#SBATCH --job-name=swimming-data
#SBATCH --output=JOB.out
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --partition=highmem

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load openmpi/4.0.5/amd
module load conda
source activate an
python collect_save.py
