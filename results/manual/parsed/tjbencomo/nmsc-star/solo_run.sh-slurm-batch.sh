#!/bin/bash
#SBATCH --job-name=star-rsem
#SBATCH --output=/scratch/users/tbencomo/nmsc-star/log2
#SBATCH --mail-user=tbencomo@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48000
#SBATCH --time=1-00:00:00

set -e
cd $(pwd)
echo "Starting snakemake..."
snakemake --use-singularity -j 24
