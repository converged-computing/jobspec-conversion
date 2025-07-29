#!/bin/bash
#SBATCH --job-name=job1
#SBATCH --account=Project_XXX
#SBATCH --output=out%j
#SBATCH --error=err%j
#SBATCH --nodes=64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:10:00
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --exclude=nid005360,nid005359

export MPICH_GPU_SUPPORT_ENABLED='1'

module load CrayEnv PrgEnv-cray craype-accel-amd-gfx90a cray-mpich rocm fftw
CPU_BIND="map_cpu:48,56,16,24,1,8,32,40"
export MPICH_GPU_SUPPORT_ENABLED=1
srun --cpu-bind=${CPU_BIND} ./program
