#!/bin/bash
#SBATCH --output=snakemake.out
#SBATCH --error=snakemake.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=3-00:00:00

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
