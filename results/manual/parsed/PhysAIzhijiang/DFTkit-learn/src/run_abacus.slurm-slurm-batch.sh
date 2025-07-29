#!/bin/bash
#SBATCH --job-name=abacus
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --chdir=./

export MKLPATH='$MKL_HOME/lib/intel64/'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$INTELPATH'
export INTELPATH='$INTEL_HOME/lib/intel64/'
export OMP_NUM_THREADS='$omp_threads'
export MKL_NUM_THREADS='$omp_threads'

module load abacus/intel-3.0.1
export MKLPATH=$MKL_HOME/lib/intel64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MKLPATH
export INTELPATH=$INTEL_HOME/lib/intel64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INTELPATH
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    omp_threads=$SLURM_CPUS_PER_TASK
else
    omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
export MKL_NUM_THREADS=$omp_threads
ABACUS_PATH=$ABACUSROOT/bin/ABACUS.mpi
