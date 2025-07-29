#!/bin/bash
#SBATCH --job-name=XXXXXX
#SBATCH --output=XXXXXX.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=prod
#SBATCH --constraint=ntasks-per-node=24

module load openmpi
module load gromacs/5.1.4-single
mpirun gmx_mpi mdrun -deffnm XXXXXX
