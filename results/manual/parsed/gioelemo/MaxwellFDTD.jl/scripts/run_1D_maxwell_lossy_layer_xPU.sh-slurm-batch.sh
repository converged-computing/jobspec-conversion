#!/bin/bash
#SBATCH --job-name=1D_additive_source_lossy_layer
#SBATCH --account=class04
#SBATCH --output=1D_additive_source_lossy_layer.%j.o
#SBATCH --error=1D_additive_source_lossy_layer.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 1D_additive_source_lossy_layer.jl
