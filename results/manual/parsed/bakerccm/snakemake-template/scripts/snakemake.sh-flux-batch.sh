#!/bin/bash
#FLUX: --job-name=outstanding-soup-9663
#FLUX: --urgency=16

module load conda2/4.2.13
source activate snakemake
snakemake --use-conda -j 8 some_rule
