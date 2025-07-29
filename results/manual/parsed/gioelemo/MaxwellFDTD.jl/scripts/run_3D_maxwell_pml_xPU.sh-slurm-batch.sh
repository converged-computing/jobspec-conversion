#!/bin/bash
#SBATCH --job-name=3D_maxwell_pml_xPU
#SBATCH --account=class04
#SBATCH --output=3D_maxwell_pml_xPU.%j.o
#SBATCH --error=3D_maxwell_pml_xPU.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 3D_maxwell_pml_xPU.jl
