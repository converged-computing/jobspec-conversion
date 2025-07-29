#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=ptest.out
#SBATCH --error=ptest.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=workq2

module load herramientas/python/3.6
PATH=/home/mroldan/.conda/envs/carto/bin:$PATH
srun python plot_test.py
