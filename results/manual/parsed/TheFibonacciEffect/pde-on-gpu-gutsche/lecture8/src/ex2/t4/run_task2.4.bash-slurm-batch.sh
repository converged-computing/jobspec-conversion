#!/bin/bash
#SBATCH --job-name=strong_scaling
#SBATCH --account=class04
#SBATCH --output=strong_scaling.%j.o
#SBATCH --error=strong_scaling.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../../.. l8_diffusion_2D_pref_multixpu._SC.jl
