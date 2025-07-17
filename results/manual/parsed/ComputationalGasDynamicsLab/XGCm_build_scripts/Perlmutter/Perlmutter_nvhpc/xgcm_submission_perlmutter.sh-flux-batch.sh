#!/bin/bash
#FLUX: --job-name=Cyclone_590k_nphi=8
#FLUX: -n=8
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=1800
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'
export MPICH_ABORT_ON_ERROR='1'

module load cudatoolkit/11.5
module load cpe-cuda
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"
export MPICH_ABORT_ON_ERROR=1
ulimit -c unlimited
srun ./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 1 0 3 input_20million_nrho=3 petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
