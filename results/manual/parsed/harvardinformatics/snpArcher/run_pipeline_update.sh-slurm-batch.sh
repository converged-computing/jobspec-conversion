#!/bin/bash
#SBATCH --job-name=sm
#SBATCH --output=out
#SBATCH --error=err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=6-06:00:00

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate snakemake
snakemake -R $(snakemake --list-params-changes) --snakefile workflow/Snakefile --profile ./profiles/slurm
