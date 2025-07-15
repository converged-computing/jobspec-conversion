#!/bin/bash
#FLUX: --job-name=chocolate-cattywampus-2779
#FLUX: --priority=16

module purge
module load Anaconda3/2020.11
source activate mk
snakemake --snakefile Snakefile_vcf2mk --profile ./profiles/slurm
