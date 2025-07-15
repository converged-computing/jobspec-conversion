#!/bin/bash
#FLUX: --job-name=red-cupcake-1809
#FLUX: --priority=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

module load PrgEnv-cray
module load amd-mixed
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest rocprof ./cmake_build_dir/kokkos_example
