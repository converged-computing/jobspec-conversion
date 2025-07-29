#!/bin/bash
#SBATCH --job-name=RNA1snakemake
#SBATCH --output=logs/RNA1snakemake_%j.out
#SBATCH --error=logs/RNA1snakemake_%j.err
#SBATCH --mail-user=lhillary@ucdavis.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-10:00:00
#SBATCH --partition=high2

source ~/.bashrc
cd rna1
snakemake --snakefile ../scripts/4-bbmap_index.smk --profile slurm --configfile ../rna1_pipeline_config.yml
