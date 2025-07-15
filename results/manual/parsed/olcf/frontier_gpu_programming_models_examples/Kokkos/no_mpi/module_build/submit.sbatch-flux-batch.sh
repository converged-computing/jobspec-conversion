#!/bin/bash
#FLUX: --job-name=chocolate-house-7695
#FLUX: --priority=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

module load DefApps
module load PrgEnv-cray
module load amd-mixed
module load kokkos/3.6.00
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/kokkos_example
