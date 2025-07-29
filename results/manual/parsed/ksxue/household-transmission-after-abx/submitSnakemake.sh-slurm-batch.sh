#!/bin/bash
#SBATCH --job-name=submitSnakemake
#SBATCH --mail-user=kxue@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00
#SBATCH --partition=relman

source activate snakemake
snakemake --use-conda --cores 24 --cluster 'sbatch -t 96:00:00 --mem=96g -c 24 -p relman' -j 25 --max-jobs-per-second 3 --max-status-checks-per-second 3
