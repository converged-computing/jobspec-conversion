#!/bin/bash
#FLUX: --job-name=rfm_LaghosTest_laghos_3_1__nvhpc___nodes___4___mpi___256___omp___1__job
#FLUX: -n=256
#FLUX: --exclusive
#FLUX: --queue=c6gn
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load laghos@3.1 %nvhpc
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun laghos -p 0 -dim 2 -rs 3 -tf 0.75 -pa > laghos.out
