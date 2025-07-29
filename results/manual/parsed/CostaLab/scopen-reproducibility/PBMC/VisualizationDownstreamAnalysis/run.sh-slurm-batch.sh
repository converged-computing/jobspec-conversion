#!/bin/bash
#SBATCH --job-name=analysis
#SBATCH --output=./analysis.txt
#SBATCH --error=./analysis.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=180G
#SBATCH --time=10:00:00

source ~/.bashrc
conda activate r-4.0.3
Rscript visualize_UMAP.R
