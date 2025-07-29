#!/bin/bash
#SBATCH --job-name=geobipy_synthetics
#SBATCH --account=sas
#SBATCH --output=%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=workq
#SBATCH --array=8,11,14,15,16,17

export OMP_NUM_THREADS='1'
export NUMBA_CPU_NAME='skylake'

module swap PrgEnv-cray/6.0.5 PrgEnv-gnu
module load cray-hdf5-parallel cray-python cray-fftw
export OMP_NUM_THREADS=1
export NUMBA_CPU_NAME='skylake'
source /caldera/hytest_scratch/scratch/nfoks/pGeobipy/bin/activate
srun python run_test_suite_parallel.py $SLURM_ARRAY_TASK_ID
