#!/bin/bash
#FLUX: --job-name=hanky-nunchucks-6650
#FLUX: --urgency=16

export CC='icc'
export CXX='icpc'
export FC='ifort'
export F77='ifort'
export F90='ifort'
export MPICC='mpiicc'
export MPICXX='mpiicpc'
export MPIFORT='mpiifort'
export MPIFC='mpiifort'
export MPIF77='mpiifort'
export MPIF90='mpiifort'
export CPATH='${MKL_INCDIR}:${MKL_F90_INC}:${CPATH} # So that mkl.h can be found'
export GEOPM_SYSTEM_DEFAULT_QUEUE='test'
export GEOPM_SBATCH_EXTRA_LINES=''

unset OMP_NUM_THREADS # Set to 1 by a default lmod module
export CC=icc
export CXX=icpc
export FC=ifort
export F77=ifort
export F90=ifort
export MPICC=mpiicc
export MPICXX=mpiicpc
export MPIFORT=mpiifort
export MPIFC=mpiifort
export MPIF77=mpiifort
export MPIF90=mpiifort
export CPATH=${MKL_INCDIR}:${MKL_F90_INC}:${CPATH} # So that mkl.h can be found
export GEOPM_SYSTEM_DEFAULT_QUEUE=test
export GEOPM_SBATCH_EXTRA_LINES="
${GEOPM_SBATCH_EXTRA_LINES}
"
