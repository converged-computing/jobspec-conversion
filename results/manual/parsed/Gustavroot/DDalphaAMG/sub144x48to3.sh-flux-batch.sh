#!/bin/bash
#FLUX: --job-name=blue-hobbit-8894
#FLUX: -N=4
#FLUX: -c=12
#FLUX: --queue=booster
#FLUX: -t=3540
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load CUDA GCC OpenMPI MPI-settings/CUDA
jutil env activate -p chwu29
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun --distribution=block:cyclic:fcyclic --cpus-per-task=${SLURM_CPUS_PER_TASK} \
    dd_alpha_amg sample144x48to3.ini
