#!/bin/bash
#SBATCH --job-name=run-gromacs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=16:00:00

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi  mdrun -deffnm md_0_1
