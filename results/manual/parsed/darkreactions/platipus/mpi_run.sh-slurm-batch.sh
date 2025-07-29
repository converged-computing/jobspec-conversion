#!/bin/bash
#SBATCH --job-name=al_svm
#SBATCH --output=al_svm.o%j
#SBATCH --error=al_svm.e%j
#SBATCH --mail-user=vshekar@haverford.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --time=04:30:00

module load python3
module list
pwd
date
ibrun python3 run_mpi.py         # Use ibrun instead of mpirun or mpiexec
