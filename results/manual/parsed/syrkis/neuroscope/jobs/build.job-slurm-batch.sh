#!/bin/bash
#SBATCH --job-name=container
#SBATCH --account=students
#SBATCH --output=logs/build.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --partition=red,brown

module load singularity
singularity build container.sif docker://syrkis/neuroscope
