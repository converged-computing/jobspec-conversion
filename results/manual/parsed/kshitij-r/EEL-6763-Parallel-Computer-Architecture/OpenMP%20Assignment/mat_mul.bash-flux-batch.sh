#!/bin/bash
#FLUX: --job-name=mat_mul
#FLUX: -n=4
#FLUX: -t=300
#FLUX: --urgency=16

module load intel
mpicc -n 2  hybrid_mat_mult.c -o hyb -fopenmp 
srun --mpi=pmix_v2 ./hyb 4
