#!/bin/bash
#FLUX: --job-name=rfm_PismTest0_pism_1_1_4__arm___nodes___1___mpi___16___omp___1__job
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=c6gn
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load pism@1.1.4 %arm
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun /usr/bin/time -f "real:%e" pismv -test A -Mx 61 -Mz 11 -y 25000 &> pismv.out
