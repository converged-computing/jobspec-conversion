#!/bin/bash
#FLUX: --job-name=muffled-earthworm-8895
#FLUX: --urgency=16

    source activate snakemake
snakemake --use-conda -c 1 demultiplex_16S
