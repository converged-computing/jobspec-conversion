#!/bin/bash
#SBATCH --job-name=DMD
#SBATCH --output=INTERACTIVE.out
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --partition=highmem

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load texlive
module load conda
source activate an
sleep 720000
