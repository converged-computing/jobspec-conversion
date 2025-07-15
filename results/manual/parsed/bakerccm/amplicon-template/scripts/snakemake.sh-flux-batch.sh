#!/bin/bash
#FLUX: --job-name=milky-leg-8613
#FLUX: --priority=16

    source activate snakemake
snakemake --use-conda -c 1 demultiplex_16S
