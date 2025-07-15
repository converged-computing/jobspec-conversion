#!/bin/bash
#FLUX: --job-name=footprint
#FLUX: --urgency=16

source activate cancergenomics
module load bedtools2-2.30.0-gcc-11.2.0
snakemake --snakefile footprint.snakefile -j 30 --keep-target-files --rerun-incomplete --cluster "sbatch -n 1 -c 1 -p general -q public --mem=50000 -t 1-00:00:00"
