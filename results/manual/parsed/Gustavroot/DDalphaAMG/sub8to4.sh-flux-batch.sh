#!/bin/bash
#FLUX: --job-name=boopy-caramel-9527
#FLUX: -c=12
#FLUX: --queue=booster
#FLUX: -t=3540
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load nano CUDA GCC OpenMPI MPI-settings/CUDA
jutil env activate -p chwu29
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun --distribution=block:cyclic:fcyclic --cpus-per-task=${SLURM_CPUS_PER_TASK} \
    dd_alpha_amg sample8to4.ini
