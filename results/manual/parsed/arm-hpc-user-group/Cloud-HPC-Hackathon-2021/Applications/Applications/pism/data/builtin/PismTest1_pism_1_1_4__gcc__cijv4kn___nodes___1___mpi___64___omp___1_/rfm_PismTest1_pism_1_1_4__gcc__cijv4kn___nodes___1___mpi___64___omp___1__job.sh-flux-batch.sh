#!/bin/bash
#FLUX: --job-name=rfm_PismTest1_pism_1_1_4__gcc__cijv4kn___nodes___1___mpi___64___omp___1__job
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=c6gn
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load pism@1.1.4 %gcc /cijv4kn
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun /usr/bin/time -f "real:%e" pismv -test B -Mx 61 -Mz 11 -ys 422.45 -y 25000 &> pismv.out
