#!/bin/bash
#SBATCH --job-name=chromvar
#SBATCH --output=./chromvar.txt
#SBATCH --error=./chromvar.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=180G
#SBATCH --time=05:00:00

source ~/.bashrc
conda activate r-4.0.3
Rscript run_chromvar.R
