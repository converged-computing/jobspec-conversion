#!/bin/bash
#SBATCH --job-name=diff2D
#SBATCH --account=class04
#SBATCH --output=diff2D.%j.o
#SBATCH --error=diff2D.%j.e
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
srun -n4 bash -c 'julia -O3 diffusion_2D_perf_multixpu.jl'
