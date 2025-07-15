#!/bin/bash
#FLUX: --job-name=outstanding-lettuce-4139
#FLUX: -N=4
#FLUX: -c=12
#FLUX: -t=3540
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load CUDA GCC OpenMPI MPI-settings/CUDA
jutil env activate -p chwu29
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun --distribution=block:cyclic:fcyclic --cpus-per-task=${SLURM_CPUS_PER_TASK} \
    dd_alpha_amg sample144x48to3.ini
