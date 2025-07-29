#!/bin/bash
#SBATCH --job-name=controljob_%j
#SBATCH --output=snakemake_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00

SNAKEMAKE_ENV=snakemake
eval "$(conda shell.bash hook)"
conda activate ${SNAKEMAKE_ENV}
snakemake --snakefile workflow/Snakefile \
          --configfile config/config.yaml \
	  --profile ./slurm \
          --rerun-triggers mtime \
          --directory "${PWD}" \
	  "${@}"
