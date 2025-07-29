#!/bin/bash
#SBATCH --job-name=snakemake_test
#SBATCH --output=snakemake_%A.out
#SBATCH --error=snakemake_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=100G
#SBATCH --time=05:00:00

cd /users/lkoffman/step_algos_test
snakemake --cores 1
