#!/bin/bash
#FLUX: --job-name=uv-coverage
#FLUX: -N=10
#FLUX: --queue=gll_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel intelmpi
module load profile/base autoload python/3.6.4
module load profile/base autoload fftw
module load profile/base autoload gsl
mpiexec -n ${SLURM_NPROCS} python create_uvcoverage_mpi.py
