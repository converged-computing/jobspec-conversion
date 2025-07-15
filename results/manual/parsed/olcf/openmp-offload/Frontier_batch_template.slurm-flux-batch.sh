#!/bin/bash
#FLUX: --job-name=fugly-pancake-6529
#FLUX: --priority=16

export OMP_NUM_THREADS='7    # for CPU OpenMP'

ulimit -s 300000   # Needed for implicit mapping example
module reset
module load PrgEnv-cray cpe/23.09 cce/16.0.1 rocm craype-accel-amd-gfx90a
cd /PATH/TO/TUTORIAL/openmp-offload/C/1-openmp-cpu/
export OMP_NUM_THREADS=7    # for CPU OpenMP
./jacobi.C.cce.exe <args>
