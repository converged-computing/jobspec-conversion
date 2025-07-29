#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=600g
#SBATCH --time=3-00:00:00

source /data/abbass2/Apps/conda/bin/activate snakes
snakemake --use-conda --cores 32
