#!/bin/bash
#FLUX: --job-name=download_bams
#FLUX: -n=11
#FLUX: --queue=standard
#FLUX: -t=21600
#FLUX: --urgency=16

snakemake -s download.smk --unlock
snakemake -s download.smk \
    --cores 11 \
    --rerun-incomplete \
    --use-conda
