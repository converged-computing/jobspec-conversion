#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00

snakemake -j 10 --cluster "sbatch -p largenode -c 16 --mem=100000 -t 2-0" --latency-wait 30
