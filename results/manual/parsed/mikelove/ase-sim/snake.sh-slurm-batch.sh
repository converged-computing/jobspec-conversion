#!/bin/bash
#SBATCH --job-name=snake
#SBATCH --mail-user=milove@email.unc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=04:00:00

snakemake -j 10 --rerun-triggers mtime --latency-wait 30 --cluster "sbatch --mem=5000 -N 1 -n 12 --time=60"
