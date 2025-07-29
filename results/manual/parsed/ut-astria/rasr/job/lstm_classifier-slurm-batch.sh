#!/bin/bash
#SBATCH --job-name=lstm
#SBATCH --account=MSS21024
#SBATCH --output=lstm.o%j
#SBATCH --error=lstm.e%j
#SBATCH --mail-user=carson.l@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:30:00
#SBATCH --partition=gpu-a100

python /work/07965/clans/ls6/Spring_RASR/rasr/scripts/model_test.py          # Do not use ibrun or any other MPI launcher
