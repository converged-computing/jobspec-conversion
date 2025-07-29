#!/bin/bash
#SBATCH --job-name=gromacs_mpi_gpu
#SBATCH --output=gromacs_mpi_gpu.%J.stdout
#SBATCH --error=gromacs_mpi_gpu.%J.stderr
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=4096
#SBATCH --time=00:30:00

module purge
module load compiler/gcc/10 openmpi/4.1 gromacs-gpu/2023
mpirun gmx mdrun -nb gpu -pme gpu -bonded gpu -npme 1
