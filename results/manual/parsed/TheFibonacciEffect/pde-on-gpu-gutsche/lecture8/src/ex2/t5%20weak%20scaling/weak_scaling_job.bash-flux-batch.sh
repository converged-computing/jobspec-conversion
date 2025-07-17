#!/bin/bash
#FLUX: --job-name=weak_scaling
#FLUX: --queue=normal
#FLUX: -t=180
#FLUX: --urgency=16

export MPICH_RDMA_ENABLED_CUDA='1'
export IGG_CUDAAWARE_MPI='1'

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=1
export IGG_CUDAAWARE_MPI=1
srun --ntasks=$1 bash -c "LD_PRELOAD=/usr/lib64/libcuda.so:/usr/local/cuda/lib64/libcudart.so julia -O3 --check-bounds=no --project=../../.. weak_scaling.jl $1"
