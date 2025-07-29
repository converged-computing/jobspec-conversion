#!/bin/bash
#SBATCH --job-name=RIBOsnakemake
#SBATCH --output=logs/RIBOsnakemake_%j.out
#SBATCH --error=logs/RIBOsnakemake_%j.err
#SBATCH --mail-user=lhillary@ucdavis.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-10:00:00

source ~/.bashrc
cd ribodepletion
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/3.1-genomad_rna.smk --profile slurm --configfile ../ribodepletion/ribodepletion_pipeline_config.yml
