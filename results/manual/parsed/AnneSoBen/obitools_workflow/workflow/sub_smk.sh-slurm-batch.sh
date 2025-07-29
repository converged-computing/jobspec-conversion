#!/bin/bash
#SBATCH --job-name=snakeflow
#SBATCH --output=snakemake_output_%j.out
#SBATCH --error=snakemake_error_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --partition=unlimitq

source activate snakemake
snakemake --cores 1 --unlock
snakemake --jobs  10 --cluster-config cluster.yaml --cluster "sbatch --mem {cluster.mem} -c {cluster.cpus}" --use-conda
