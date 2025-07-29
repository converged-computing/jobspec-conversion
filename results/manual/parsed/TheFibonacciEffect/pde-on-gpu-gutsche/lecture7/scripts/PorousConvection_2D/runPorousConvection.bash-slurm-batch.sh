#!/bin/bash
#SBATCH --job-name=PC_2D_daint
#SBATCH --account=class04
#SBATCH --output=PC_2D_daint.%j.o
#SBATCH --error=PC_2D_daint.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:30:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../.. ./PorousConvection_2D_xpu_daint.jl 511 1023 4000
