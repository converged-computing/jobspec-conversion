#!/bin/bash
#FLUX: --job-name=lovable-nalgas-4361
#FLUX: -N=36
#FLUX: -c=12
#FLUX: -t=3540
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load nano CUDA GCC OpenMPI MPI-settings/CUDA
jutil env activate -p mul-tra
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun --distribution=block:cyclic:fcyclic --cpus-per-task=${SLURM_CPUS_PER_TASK} \
    dd_alpha_amg sample_E250_GPU.ini
