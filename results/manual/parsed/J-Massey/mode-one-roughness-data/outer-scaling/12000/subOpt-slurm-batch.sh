#!/bin/bash
#SBATCH --job-name=12k
#SBATCH --output=JOB.out
#SBATCH --nodes=4
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load openmpi/4.0.5/amd
python run-val.py
