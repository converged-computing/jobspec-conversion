#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=snakemake.sbatch.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-08:00:00

snakemake --profile snakemake_profiles/slurm
