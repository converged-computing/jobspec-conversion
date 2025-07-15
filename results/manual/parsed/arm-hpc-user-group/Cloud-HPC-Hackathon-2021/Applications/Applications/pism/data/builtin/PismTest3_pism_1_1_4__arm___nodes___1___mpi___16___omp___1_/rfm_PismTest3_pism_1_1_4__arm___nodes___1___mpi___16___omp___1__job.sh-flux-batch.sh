#!/bin/bash
#FLUX: --job-name="rfm_PismTest3_pism_1_1_4__arm___nodes___1___mpi___16___omp___1__job"
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load pism@1.1.4 %arm
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun /usr/bin/time -f "real:%e" pismv -test D -Mx 61 -Mz 11 -y 25000 &> pismv.out
