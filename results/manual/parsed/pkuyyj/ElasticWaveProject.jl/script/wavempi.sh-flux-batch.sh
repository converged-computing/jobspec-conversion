#!/bin/bash
#FLUX: --job-name="wave3D"
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --priority=16

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
nvidia-smi
/scratch/snx3000/julia/class222/daint-gpu/bin/mpiexecjl  -n 4 julia --project -O2 src/wave3D_multixpu.jl
