#!/bin/bash
#SBATCH --job-name=1AKI_50
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=2-00:00:00

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 10  gmx_mpi mdrun -deffnm md_50
