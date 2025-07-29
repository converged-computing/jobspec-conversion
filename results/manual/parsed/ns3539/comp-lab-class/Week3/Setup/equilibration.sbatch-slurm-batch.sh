#!/bin/bash
#SBATCH --job-name=run-gromacs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi mdrun -deffnm npt_eq
