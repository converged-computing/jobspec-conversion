#!/bin/bash
#SBATCH --job-name=FusedMM4DGL
#SBATCH --output=FusedMM4DGL.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-06:30:00
#SBATCH --partition=azad

module unload gcc
module load gcc
srun -p azad -N 1 -n 1 -c 1 bash run_all.sh
