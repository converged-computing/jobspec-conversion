#!/bin/bash
#FLUX: --job-name="3D_Lava_Lamp"
#FLUX: -N=8
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --priority=16

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
srun -n8 bash -c 'julia -O3 ThermalConvection3D.jl'
