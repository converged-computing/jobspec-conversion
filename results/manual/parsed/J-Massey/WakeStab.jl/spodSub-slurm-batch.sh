#!/bin/bash
#SBATCH --job-name=SPOD
#SBATCH --output=SPOD.out
#SBATCH --nodes=2
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --exclusive

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load texlive
python src/SPOD.py
