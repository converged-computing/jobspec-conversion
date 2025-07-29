#!/bin/bash
#SBATCH --job-name=PC_3D 127 2000 false true
#SBATCH --account=class04
#SBATCH --output=PC_3D.%j.o
#SBATCH --error=PC_3D.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../.. ./PorousConvection_3D_xpu.jl
