#!/bin/bash
#SBATCH --job-name=singularity_build
#SBATCH --output=singularity_build_output_%j.txt
#SBATCH --error=singularity_build_error_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G

srun singularity build --remote singularity_image.sif singularity/singularity_image.def
