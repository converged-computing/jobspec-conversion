#!/bin/bash
#SBATCH --output=slurm/snakemake.out
#SBATCH --error=slurm/snakemake.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:01:00
#SBATCH --partition=shared

    source activate snakemake
snakemake --use-conda -c 1 demultiplex_16S
