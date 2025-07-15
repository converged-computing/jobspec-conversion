#!/bin/bash
#FLUX: --job-name=darts-openmp
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='24'

module swap PrgEnv-cray PrgEnv-intel 
export OMP_NUM_THREADS=24
srun --export=all -n 1 -c 24 darts-omp
