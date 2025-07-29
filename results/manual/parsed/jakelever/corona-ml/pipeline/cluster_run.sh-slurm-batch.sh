#!/bin/bash
#SBATCH --job-name=coronaPipeline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00

set -ex
snakemake --cores 1 -p data/coronacentral.json
