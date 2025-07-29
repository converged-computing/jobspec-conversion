#!/bin/bash
#SBATCH --job-name=wave3D
#SBATCH --account=class04
#SBATCH --output=log/wave3D.%j.o
#SBATCH --error=log/wave3D.%j.e
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

export MPICH_RDMA_ENABLED_CUDA='0'
export IGG_CUDAAWARE_MPI='0'

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
export MPICH_RDMA_ENABLED_CUDA=0
export IGG_CUDAAWARE_MPI=0
nvidia-smi
/scratch/snx3000/julia/class222/daint-gpu/bin/mpiexecjl  -n 4 julia --project -O2 src/wave3D_multixpu.jl
