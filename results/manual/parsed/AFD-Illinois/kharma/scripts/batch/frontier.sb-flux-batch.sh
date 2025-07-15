#!/bin/bash
#FLUX: --job-name=carnivorous-ricecake-3867
#FLUX: --priority=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export KOKKOS_MAP_DEVICE_ID_BY='mpi_rank'
export MPICH_GPU_SUPPORT_ENABLED='1'

KHARMA_DIR=~/Code/kharma
module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load cray-hdf5-parallel
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export KOKKOS_MAP_DEVICE_ID_BY=mpi_rank
export MPICH_GPU_SUPPORT_ENABLED=1
srun -n $((8 * $SLURM_NNODES )) -c 1 --gpus-per-node=8 --gpu-bind=closest $KHARMA_DIR/kharma.hip -t 1:50:00 "$@"
