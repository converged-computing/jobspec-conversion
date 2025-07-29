#!/bin/bash
#SBATCH --job-name=SlurmJob
#SBATCH --output=slurm-%j.out
#SBATCH --mail-user=mike.lloyd@jax.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=3-00:00:00

nextflow run ./download-references.nf -profile singularity --download_all --cosmic_usr mike.lloyd@jax.org --cosmic_passwd YSYLTvNy72fvxg!
