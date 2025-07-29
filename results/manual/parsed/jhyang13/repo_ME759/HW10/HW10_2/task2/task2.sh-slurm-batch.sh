#!/bin/bash
#SBATCH --job-name=task2
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load mpi/openmpi
module load nvidia/cuda/11.8
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
mpicxx task2.cpp reduce.cpp -Wall -O3 -o task2 -fopenmp -fno-tree-vectorize -march=native -fopt-info-vec
n=7
t=1
srun -n 2 --cpu-bind=none ./task2 $n $t
