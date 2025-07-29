#!/bin/bash
#SBATCH --job-name=controljob_%j
#SBATCH --output=snakemake_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3500
#SBATCH --time=2-00:00:00
#SBATCH --partition=longrun

SNAKEMAKE_ENV='snakemake'
eval "$(conda shell.bash hook)"
conda activate ${SNAKEMAKE_ENV}
snakemake --snakefile workflow/Snakefile \
          --profile ./slurm \
          --directory "${PWD}" \
          "${@}"
