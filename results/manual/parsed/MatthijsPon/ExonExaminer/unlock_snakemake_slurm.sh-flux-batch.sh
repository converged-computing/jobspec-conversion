#!/bin/bash
#FLUX: --job-name=unlock_snakemake
#FLUX: -t=120
#FLUX: --priority=16

module load tools/miniconda/python3.8/4.9.2
conda activate exonexaminer
snakemake --unlock
