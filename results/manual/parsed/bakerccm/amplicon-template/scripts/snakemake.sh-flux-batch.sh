#!/bin/bash
#FLUX: --job-name=expensive-ricecake-2727
#FLUX: --queue=shared
#FLUX: -t=60
#FLUX: --urgency=16

    source activate snakemake
snakemake --use-conda -c 1 demultiplex_16S
