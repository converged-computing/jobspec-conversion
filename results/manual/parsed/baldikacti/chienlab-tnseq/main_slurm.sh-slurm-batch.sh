#!/bin/bash
#SBATCH --job-name=chienlab-tnseq-ba
#SBATCH --output=logs/chienlab-tnseq-ba_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=240gb
#SBATCH --time=06:00:00
#SBATCH --partition=cpu

date;hostname;pwd
module load miniconda/22.11.1-1
conda activate /work/pi_pchien_umass_edu/berent/chienlab-tnseq/conda-tnseq
snakemake -q rules --profile profiles/default
date
