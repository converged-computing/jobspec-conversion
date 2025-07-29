#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=out_snakemake
#SBATCH --error=err_snakemake
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

source ~/miniforge3/etc/profile.d/conda.sh
conda activate bioinformatics
GIT_REPO_DIR=/scratch/gpfs/bjarnold/intro_compbio_workflows_2024
snakemake --directory ../ --snakefile ../Snakefile \
--profile ${GIT_REPO_DIR}/snakemake_profiles/slurm
