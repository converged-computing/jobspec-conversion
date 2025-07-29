#!/bin/bash
#SBATCH --job-name=breseq_snakemake
#SBATCH --output=masterout.txt
#SBATCH --error=mastererr.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=1-06:00:00

bash snakemakeslurm.sh
echo Done!!!
