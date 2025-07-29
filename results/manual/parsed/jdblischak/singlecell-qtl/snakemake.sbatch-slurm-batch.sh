#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=snakelog.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gilad

source activate scqtl
bash submit-snakemake.sh $*
