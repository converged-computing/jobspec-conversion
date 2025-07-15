#!/bin/bash
#FLUX: --job-name=snake
#FLUX: -t=72000
#FLUX: --priority=16

module load python
module load samtools
snakemake -j 9 --latency-wait 30 --cluster "sbatch -n 12 --mem=15000 --time=360"
