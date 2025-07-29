#!/bin/bash
#SBATCH --job-name=MyMPIJob
#SBATCH --output=MPI-%j.out
#SBATCH --error=MPI-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module load gcc/10.2 cuda/11.7.1
module load mpi/openmpi_4.1.1_gcc_10.2_slurm22
mpic++ -O3 Poisson1D_Jacobi_MPI.cpp -o Poisson1D_Jacobi_MPI.out
echo "Compiled"
srun --mpi=pmix ./Poisson1D_Jacobi_MPI.out
