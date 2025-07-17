#!/bin/bash
#FLUX: --job-name=omp
#FLUX: -c=40
#FLUX: --queue=dev
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='40'
export OMP_PROC_BIND='true'

source /opt/modules/default/init/bash
module switch PrgEnv-intel PrgEnv-gnu
module unload cray-libsci/18.04.1
module load intel
module load cray-fftw
export OMP_NUM_THREADS=40
export OMP_PROC_BIND=true
srun ./vlp4d.skx_omp SLD10.dat
