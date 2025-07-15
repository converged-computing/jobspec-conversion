#!/bin/bash
#FLUX: --job-name=lovable-fork-0647
#FLUX: -c=4
#FLUX: -t=1800
#FLUX: --urgency=16

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
