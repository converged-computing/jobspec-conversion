#!/bin/bash
#SBATCH --job-name=format_refseq
#SBATCH --account=default
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=6G
#SBATCH --time=5-00:00:00
#SBATCH --partition=interactive

module load r/3.6
snakemake -j 12 --latency-wait=90
