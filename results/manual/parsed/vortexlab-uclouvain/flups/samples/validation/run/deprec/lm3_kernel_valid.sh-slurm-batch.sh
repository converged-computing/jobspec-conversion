#!/bin/bash
#SBATCH --job-name=NAPS-like
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2625
#SBATCH --time=01:00:00
#SBATCH --partition=batch

export OMP_NUM_THREADS='${MY_NTHREADS}'

export OMP_NUM_THREADS=${MY_NTHREADS}
echo "----------------- Load modules -----------------"
module purge
module load intel/2018b
module load HDF5/1.10.2-intel-2018b
module list
EXEC_FLUPS=flups_validation
srun --label ${EXEC_FLUPS} -np ${MY_NX} ${MY_NY} ${MY_NZ} -res ${MY_SIZE} -nres 1 -ns 100 -k 0
