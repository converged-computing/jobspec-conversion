#!/bin/bash
#SBATCH --account=cfang
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

source ~/env/bin/activate
module load singularity
snakemake -s ~/automl_scrna/scripts/automl_snakefile --unlock --jobs 50 --use-singularity --profile ~/slurm
snakemake -s ~/automl_scrna/scripts/automl_snakefile --rerun-incomplete  --jobs 50 -k  --use-singularity --profile ~/slurm 
