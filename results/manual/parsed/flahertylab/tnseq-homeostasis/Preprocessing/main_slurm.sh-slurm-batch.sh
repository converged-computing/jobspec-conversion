#!/bin/bash
#SBATCH --job-name=chienlab-tnseq-ba
#SBATCH --output=logs/chienlab-tnseq-ba_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32gb
#SBATCH --time=06:00:00

date;hostname;pwd
module load miniconda/22.11.1-1
conda activate chienlab-tnseq
snakemake all --cores
date
