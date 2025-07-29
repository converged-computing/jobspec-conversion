#!/bin/bash
#FLUX --job-name=ornery-egg-7973
#FLUX --queue=shared
#FLUX -t=60
#FLUX --urgency=16

    source activate snakemake
snakemake --use-conda -c 1 demultiplex_16S
