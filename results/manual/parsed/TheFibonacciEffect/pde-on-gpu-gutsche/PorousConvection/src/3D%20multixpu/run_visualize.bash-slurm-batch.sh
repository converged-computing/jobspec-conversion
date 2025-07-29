#!/bin/bash
#SBATCH --job-name=viz_3D_porous_convection
#SBATCH --account=class04
#SBATCH --output=viz_3D_porous_convection.%j.o
#SBATCH --error=viz_3D_porous_convection.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1,gpu

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia --project=../.. ./visualise.jl
