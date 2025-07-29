#!/bin/bash
#SBATCH --job-name=mpi_grayscale
#SBATCH --account=isu102
#SBATCH --output=mpi_grayscale.%j.%N.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=128

module load cpu/0.15.4 gcc/10.2.0 openmpi/4.0.4
srun -n 1 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 2 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 5 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 10 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 20 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
