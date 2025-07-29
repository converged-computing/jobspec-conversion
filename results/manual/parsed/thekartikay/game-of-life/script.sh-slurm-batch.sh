#!/bin/bash
#SBATCH --job-name=PROJECT_2
#SBATCH --output=project_2_%j.out
#SBATCH --error=project_2_%j.err
#SBATCH --mail-user=avi_kartikay@gwu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=c1exp
#SBATCH --chdir=/home/avi_kartikay/Project_2/AVI_KARTIKAY_DATS6402_10_PROJECT_2

module load mpi4py
mpirun -n 28 singularity exec --bind /groups --bind /lustre /groups/dats6402_10/images/python-3.7.0+ompi.simg python3 code.py
