#!/bin/bash
#SBATCH --job-name=HIP
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --time=00:01:00
#SBATCH --qos=gpu-shd

export MPICH_GPU_SUPPORT_ENABLED='1'

module load PrgEnv-amd
module load rocm
module load craype-accel-amd-gfx90a
module load craype-x86-milan
module load cray-libsci_acc
export MPICH_GPU_SUPPORT_ENABLED=1
srun --ntasks=2 --cpus-per-task=8 ./a.out
