#!/bin/bash
#FLUX: --job-name=sm
#FLUX: --queue=holy-info
#FLUX: -t=540000
#FLUX: --urgency=16

module purge
module load Anaconda3/2020.11
source activate mk
snakemake --snakefile Snakefile_vcf2mk --profile ./profiles/slurm
