#!/bin/bash
#FLUX: --job-name=task2
#FLUX: -N=2
#FLUX: -c=20
#FLUX: --queue=instruction
#FLUX: -t=1800
#FLUX: --urgency=16

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
