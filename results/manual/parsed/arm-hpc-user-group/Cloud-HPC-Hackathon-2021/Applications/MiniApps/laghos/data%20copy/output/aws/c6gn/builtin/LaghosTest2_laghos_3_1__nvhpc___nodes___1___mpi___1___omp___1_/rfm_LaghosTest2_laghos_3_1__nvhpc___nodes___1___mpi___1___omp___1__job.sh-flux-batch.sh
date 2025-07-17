#!/bin/bash
#FLUX: --job-name=rfm_LaghosTest2_laghos_3_1__nvhpc___nodes___1___mpi___1___omp___1__job
#FLUX: --exclusive
#FLUX: --queue=c6gn
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load laghos@3.1 %nvhpc
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun laghos -p 1 -dim 2 -rs 3 -tf 0.8 -pa > laghos.out
