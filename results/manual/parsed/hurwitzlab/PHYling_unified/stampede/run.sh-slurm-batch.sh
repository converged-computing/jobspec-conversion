#!/bin/bash
#SBATCH --job-name=phyling
#SBATCH --account=iPlant-Collabs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal

module load tacc-singularity
set -u
singularity run phyling.img
