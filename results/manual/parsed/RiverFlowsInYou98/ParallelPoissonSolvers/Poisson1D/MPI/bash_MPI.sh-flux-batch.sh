#!/bin/bash
#FLUX: --job-name=outstanding-eagle-8276
#FLUX: -t=3600
#FLUX: --priority=16

module load gcc/10.2 cuda/11.7.1
module load mpi/openmpi_4.1.1_gcc_10.2_slurm22
mpic++ -O3 Poisson1D_Jacobi_MPI.cpp -o Poisson1D_Jacobi_MPI.out
echo "Compiled"
srun --mpi=pmix ./Poisson1D_Jacobi_MPI.out
