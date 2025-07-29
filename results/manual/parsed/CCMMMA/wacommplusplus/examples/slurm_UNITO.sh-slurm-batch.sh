#!/bin/bash
#FLUX: --job-name=wpp
#FLUX: --queue=broadwell
#FLUX: --urgency=16

export OMP_NUM_THREADS='$omp_threads'

spack load cmake@3.26.3%gcc@=9.4.0 arch=linux-ubuntu20.04-broadwell
spack load openmpi@4.1.5%gcc@=9.4.0 arch=linux-ubuntu20.04-zen
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
mpirun --bind-to none --mca orte_base_help_aggregate 0 ./wacommplusplus
