#!/bin/bash
#FLUX: --job-name="rfm_LaghosTest0_branson_0_82__arm___nodes___1___mpi___64___omp___1__job"
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load branson@0.82 %arm
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
cp /home/iman/rfms/branson/proxy_small.xml ./branson.in
srun BRANSON ./branson.in > branson.out
