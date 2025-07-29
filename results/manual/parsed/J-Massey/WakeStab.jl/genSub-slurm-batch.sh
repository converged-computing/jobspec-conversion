#!/bin/bash
#SBATCH --job-name=wake-RA
#SBATCH --output=RAND-RA.out
#SBATCH --nodes=2
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --partition=highmem

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load texlive
python src/DMD-RA-working.py
