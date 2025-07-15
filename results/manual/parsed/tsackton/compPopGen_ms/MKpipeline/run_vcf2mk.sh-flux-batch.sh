#!/bin/bash
#FLUX: --job-name=expensive-carrot-1527
#FLUX: --urgency=16

module purge
module load Anaconda3/2020.11
source activate mk
snakemake --snakefile Snakefile_vcf2mk --profile ./profiles/slurm
