#!/bin/bash
#FLUX: --job-name=placid-squidward-7915
#FLUX: --priority=16

module load conda2/4.2.13
source activate snakemake
snakemake --use-conda -j 8 some_rule
