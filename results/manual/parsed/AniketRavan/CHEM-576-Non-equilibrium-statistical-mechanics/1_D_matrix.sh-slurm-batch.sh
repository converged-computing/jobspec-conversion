#!/bin/bash
#SBATCH --job-name=langevin_overdamped
#SBATCH --output=langevin_overdamped
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50g
#SBATCH --partition=normal

echo "Loading module"
echo "Loaded module. Running python"
module load Python/3.6.1-IGB-gcc-4.9.4
python 1_D_matrix.py
