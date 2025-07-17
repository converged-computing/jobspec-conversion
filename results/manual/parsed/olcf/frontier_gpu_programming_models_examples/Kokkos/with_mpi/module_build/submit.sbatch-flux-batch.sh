#!/bin/bash
#FLUX: --job-name=buttery-onion-7060
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

module load PrgEnv-cray
module load amd-mixed
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
srun -N1 -n4 -c4 --gpus-per-task=1 --gpu-bind=closest rocprof -d results ./cmake_build_dir/kokkos_example
