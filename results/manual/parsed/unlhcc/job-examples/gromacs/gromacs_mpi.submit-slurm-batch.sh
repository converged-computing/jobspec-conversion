#!/bin/bash
#SBATCH --job-name=gromacs_mpi
#SBATCH --output=gromacs_mpi.%J.stdout
#SBATCH --error=gromacs_mpi.%J.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024
#SBATCH --time=01:00:00

module purge
module load compiler/gcc/10 openmpi/4.1 gromacs-gpu/2023
mpirun gmx mdrun
