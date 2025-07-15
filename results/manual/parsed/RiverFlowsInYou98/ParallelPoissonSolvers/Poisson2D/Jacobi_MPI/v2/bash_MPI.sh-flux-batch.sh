#!/bin/bash
#FLUX: --job-name=adorable-plant-9437
#FLUX: -t=3600
#FLUX: --urgency=16

module load gcc/10.2 cuda/11.7.1
module load mpi/openmpi_4.1.1_gcc_10.2_slurm22
mpic++ -O3 Poisson2D_Jacobi_MPI.cpp -o Poisson2D_Jacobi_MPI.out
echo "Compiled"
srun --mpi=pmix ./Poisson2D_Jacobi_MPI.out
