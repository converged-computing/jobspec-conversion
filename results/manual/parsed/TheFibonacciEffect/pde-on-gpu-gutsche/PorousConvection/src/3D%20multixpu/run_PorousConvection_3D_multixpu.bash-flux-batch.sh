#!/bin/bash
#FLUX: --job-name="3D_porous_convection"
#FLUX: -N=8
#FLUX: --queue=normal
#FLUX: -t=25200
#FLUX: --priority=16

export MPICH_RDMA_ENABLED_CUDA='1'
export IGG_CUDAAWARE_MPI='1'

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=1
export IGG_CUDAAWARE_MPI=1
srun -n8 bash -c 'LD_PRELOAD="/usr/lib64/libcuda.so:/usr/local/cuda/lib64/libcudart.so" julia -O3 --check-bounds=no --project=../.. PorousConvection_3D_multixpu.jl'
