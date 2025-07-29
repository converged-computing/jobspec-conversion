#!/bin/bash
#SBATCH --job-name=dada2
#SBATCH --account=<your-account>
#SBATCH --output=data/logs/1_dada2_%J.out
#SBATCH --error=data/logs/1_dada2_%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48

module load gcc
module load R
Rscript scripts/preprocessing/01_dada2-error-output.R \
        data/trimmed \
        data/dada2/ \
        blanes_project \
        230,220 \
        2,6 \
        15
