#!/bin/bash
#FLUX: --job-name=diff2D
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=120
#FLUX: --urgency=16

export MPICH_RDMA_ENABLED_CUDA='1'
export IGG_CUDAAWARE_MPI='1'

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=1
export IGG_CUDAAWARE_MPI=1
srun -n4 bash -c 'LD_PRELOAD="/usr/lib64/libcuda.so:/usr/local/cuda/lib64/libcudart.so" julia -O3 --check-bounds=no --project=.. l8_diffusion_2D_mpi_gpu.jl'
