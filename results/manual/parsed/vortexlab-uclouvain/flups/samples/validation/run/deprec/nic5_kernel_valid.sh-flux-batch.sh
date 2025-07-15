#!/bin/bash
#FLUX: --job-name=vector-validation
#FLUX: --queue=batch
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='${MY_NTHREADS}'

export OMP_NUM_THREADS=${MY_NTHREADS}
echo "----------------- Load modules -----------------"
module purge
module load FFTW/3.3.8-gompi-2020b HDF5/1.10.7-gompi-2020b
module list
EXEC_FLUPS=flups_validation_nb
mpirun ${EXEC_FLUPS} -np ${MY_NX} ${MY_NY} ${MY_NZ} -res ${MY_SIZEX} ${MY_SIZEY} ${MY_SIZEZ} -nres ${MY_NRES} -ns ${MY_NSOLVE} -k ${MY_KERNEL} -c 0 -bc ${MY_BC}
