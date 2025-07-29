#!/bin/bash
#SBATCH --job-name=task2.3
#SBATCH --account=class04
#SBATCH --output=task2.3.%j.o
#SBATCH --error=task2.3.%j.e
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export MPICH_RDMA_ENABLED_CUDA='1'
export IGG_CUDAAWARE_MPI='1'

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=1
export IGG_CUDAAWARE_MPI=1
srun -n4 bash -c 'LD_PRELOAD="/usr/lib64/libcuda.so:/usr/local/cuda/lib64/libcudart.so" julia -O3 --check-bounds=no --project=../../.. run_l8_diffusion_2D_perf_multixpu.jl'
