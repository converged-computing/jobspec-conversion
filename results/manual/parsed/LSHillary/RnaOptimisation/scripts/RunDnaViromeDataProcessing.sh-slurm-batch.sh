#!/bin/bash
#SBATCH --job-name=DNAsnakemake
#SBATCH --output=logs/DNAsnakemake_%j.out
#SBATCH --error=logs/DNAsnakemake_%j.err
#SBATCH --mail-user=lhillary@ucdavis.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=high2

source ~/.bashrc
cd dna
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/4-bbmap_dna.smk --profile slurm --configfile ../dna_pipeline_config.yml
