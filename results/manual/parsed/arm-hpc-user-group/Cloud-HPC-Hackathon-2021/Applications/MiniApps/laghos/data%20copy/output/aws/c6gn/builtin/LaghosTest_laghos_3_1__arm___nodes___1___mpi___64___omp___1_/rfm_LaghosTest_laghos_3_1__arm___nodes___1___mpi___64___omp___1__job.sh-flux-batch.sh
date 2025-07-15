#!/bin/bash
#FLUX: --job-name=rfm_LaghosTest_laghos_3_1__arm___nodes___1___mpi___64___omp___1__job
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load laghos@3.1 %arm
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun laghos -p 0 -dim 2 -rs 3 -tf 0.75 -pa > laghos.out
