#!/bin/bash
#SBATCH --job-name=sm
#SBATCH --output=out
#SBATCH --error=err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=6-06:00:00
#SBATCH --partition=holy-info

module purge
module load Anaconda3/2020.11
source activate mk
snakemake --snakefile Snakefile_vcf2mk --profile ./profiles/slurm
