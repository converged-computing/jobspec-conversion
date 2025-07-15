#!/bin/bash
#FLUX: --job-name=Cyclone_590k_nphi=8
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'
export MPICH_ABORT_ON_ERROR='1'

module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"
export MPICH_ABORT_ON_ERROR=1
ulimit -c unlimited
srun hostname
scontrol show jobid ${SLURM_JOB_ID}
srun ./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 1 0 3 input_20million_nrho=3 petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
