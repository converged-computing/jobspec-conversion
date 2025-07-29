#!/bin/bash
#SBATCH --job-name=3D_Lava_Lamp
#SBATCH --account=class04
#SBATCH --output=my_gpu_run.%j.o
#SBATCH --error=my_gpu_run.%j.e
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
srun -n8 bash -c 'julia -O3 ThermalConvection3D.jl'
