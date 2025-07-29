#!/bin/bash
#SBATCH --job-name=convect3D
#SBATCH --account=class04
#SBATCH --output=convect3D.%j.o
#SBATCH --error=convect3D.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 PorousConvection_3D_xpu.jl
