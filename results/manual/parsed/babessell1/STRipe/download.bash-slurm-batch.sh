#!/bin/bash
#SBATCH --job-name=download_bams
#SBATCH --account=bioinf593f23_class
#SBATCH --output=logs/stripe_download.out
#SBATCH --error=logs/stripe_download.err
#SBATCH --nodes=1
#SBATCH --ntasks=11
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=11GB
#SBATCH --time=06:00:00

snakemake -s download.smk --unlock
snakemake -s download.smk \
    --cores 11 \
    --rerun-incomplete \
    --use-conda
