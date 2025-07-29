#!/bin/bash
#FLUX: --job-name=diff2D
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
srun -n4 bash -c 'julia -O3 diffusion_2D_perf_multixpu.jl'
