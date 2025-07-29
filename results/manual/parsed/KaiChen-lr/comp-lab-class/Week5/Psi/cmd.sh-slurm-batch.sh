#!/bin/bash
#SBATCH --job-name=npt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=1-16:00:00

module purge
module load gromacs/openmpi/intel/2018.3
mpirun -np 1 gmx_mpi mdrun -deffnm adp
