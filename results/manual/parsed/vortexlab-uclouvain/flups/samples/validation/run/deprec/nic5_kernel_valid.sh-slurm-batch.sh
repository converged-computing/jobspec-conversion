#!/bin/bash
#SBATCH --job-name=vector-validation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2625
#SBATCH --time=00:15:00
#SBATCH --partition=batch

export OMP_NUM_THREADS='${MY_NTHREADS}'

export OMP_NUM_THREADS=${MY_NTHREADS}
echo "----------------- Load modules -----------------"
module purge
module load FFTW/3.3.8-gompi-2020b HDF5/1.10.7-gompi-2020b
module list
EXEC_FLUPS=flups_validation_nb
mpirun ${EXEC_FLUPS} -np ${MY_NX} ${MY_NY} ${MY_NZ} -res ${MY_SIZEX} ${MY_SIZEY} ${MY_SIZEZ} -nres ${MY_NRES} -ns ${MY_NSOLVE} -k ${MY_KERNEL} -c 0 -bc ${MY_BC}
