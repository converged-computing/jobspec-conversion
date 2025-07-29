#!/bin/bash
#SBATCH --job-name=main_admixcov_data
#SBATCH --account=gmcoopgrp
#SBATCH --output=main_snakemake.out
#SBATCH --error=main_snakemake.err
#SBATCH --mail-user=acpsimon@ucdavis.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000M
#SBATCH --time=10-00:00:00

module load miniconda3
snakemake --profile farm-profile
