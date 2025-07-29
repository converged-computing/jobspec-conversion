#!/bin/bash
#SBATCH --job-name=footprint
#SBATCH --mail-user=eknodel@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40000
#SBATCH --time=2-00:00:00

source activate cancergenomics
module load bedtools2-2.30.0-gcc-11.2.0
snakemake --snakefile footprint.snakefile -j 30 --keep-target-files --rerun-incomplete --cluster "sbatch -n 1 -c 1 -p general -q public --mem=50000 -t 1-00:00:00"
