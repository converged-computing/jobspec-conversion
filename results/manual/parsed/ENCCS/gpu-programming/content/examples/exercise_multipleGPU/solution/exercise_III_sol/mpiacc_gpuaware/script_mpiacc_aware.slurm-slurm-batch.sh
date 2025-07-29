#!/bin/bash
#SBATCH --job-name=gpuaware-mpiacc
#SBATCH --account=project_465000485
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=4

export MPICH_GPU_SUPPORT_ENABLED='1'

module load CrayEnv
module load PrgEnv-cray
module load cray-mpich
module load craype-accel-amd-gfx90a
module load rocm
export MPICH_GPU_SUPPORT_ENABLED=1
time srun ./laplace.gpuaware.mpiacc.exe
rocm-smi --showtoponuma
