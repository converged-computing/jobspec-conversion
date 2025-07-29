#!/bin/bash
#SBATCH --job-name=convect2D
#SBATCH --account=class04
#SBATCH --output=convect2D.%j.o
#SBATCH --error=convect2D.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia --check-bounds=no -O3 PorousConvection_2D_xpu.jl
