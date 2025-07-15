#!/bin/bash
#FLUX: --job-name=phat-arm-6040
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'
export ROCPROF='$ROCM_PATH/bin/rocprof'

module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
export ROCPROF=$ROCM_PATH/bin/rocprof
srun -N1 -n1 -c4 --gpus-per-task=4 --gpu-bind=closest $ROCPROF ./make_build_dir/jacobi 10000 100 
