#!/bin/bash
#FLUX: --job-name=gpuaware-mpiacc
#FLUX: --queue=standard-g
#FLUX: -t=300
#FLUX: --priority=16

export MPICH_GPU_SUPPORT_ENABLED='1'

module load CrayEnv
module load PrgEnv-cray
module load cray-mpich
module load craype-accel-amd-gfx90a
module load rocm
export MPICH_GPU_SUPPORT_ENABLED=1
time srun ./laplace.gpuaware.mpiacc.exe
rocm-smi --showtoponuma
