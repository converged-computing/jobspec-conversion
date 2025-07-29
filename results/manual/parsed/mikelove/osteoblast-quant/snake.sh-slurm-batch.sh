#!/bin/bash
#SBATCH --job-name=snake
#SBATCH --mail-user=milove@email.unc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=20:00:00

module load python
module load samtools
snakemake -j 9 --latency-wait 30 --cluster "sbatch -n 12 --mem=15000 --time=360"
