#!/bin/bash
#SBATCH --account=innovation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=8G
#SBATCH --time=00:10:00

module load 2022r2 openmpi py-torch
srun python gpu_dl_pytorch.py > gpu_dl_pytorch.log
