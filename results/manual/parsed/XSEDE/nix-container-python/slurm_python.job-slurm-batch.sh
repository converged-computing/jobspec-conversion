#!/bin/bash
#SBATCH --output=sing_test_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --partition=cloud

module purge
module load singularity
singularity run nix-container-python.sif
