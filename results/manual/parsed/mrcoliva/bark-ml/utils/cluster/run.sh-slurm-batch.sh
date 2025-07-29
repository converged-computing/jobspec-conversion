#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10GB
#SBATCH --qos=lowprio

srun singularity exec --nv ../images/bark_ml.img python3 -u ./configuration 
