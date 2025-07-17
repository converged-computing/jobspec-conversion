#!/bin/bash
#FLUX: --job-name=dada2
#FLUX: -c=48
#FLUX: --urgency=16

module load gcc
module load R
Rscript scripts/preprocessing/01_dada2-error-output.R \
        data/trimmed \
        data/dada2/ \
        blanes_project \
        230,220 \
        2,6 \
        15
