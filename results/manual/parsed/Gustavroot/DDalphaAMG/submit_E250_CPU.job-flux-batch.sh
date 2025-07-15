#!/bin/bash
#FLUX: --job-name=expensive-arm-2418
#FLUX: -N=72
#FLUX: --queue=batch
#FLUX: -t=3540
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load nano GCC OpenMPI
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun --distribution=block:cyclic:fcyclic --cpus-per-task=${SLURM_CPUS_PER_TASK} \
    dd_alpha_amg sample_E250_CPU.ini
