#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=800g
#SBATCH --time=06:00:00

module load snakemake
snakemake --use-conda --cores 36
