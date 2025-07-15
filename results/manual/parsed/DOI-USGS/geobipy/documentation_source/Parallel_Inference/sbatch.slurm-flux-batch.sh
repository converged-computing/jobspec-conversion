#!/bin/bash
#FLUX: --job-name=geobipy_synthetics
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export NUMBA_CPU_NAME='skylake'

module swap PrgEnv-cray/6.0.5 PrgEnv-gnu
module load cray-hdf5-parallel cray-python cray-fftw
export OMP_NUM_THREADS=1
export NUMBA_CPU_NAME='skylake'
source /caldera/hytest_scratch/scratch/nfoks/pGeobipy/bin/activate
srun python run_test_suite_parallel.py $SLURM_ARRAY_TASK_ID
