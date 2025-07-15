#!/bin/bash
#FLUX: --job-name=butterscotch-fork-7357
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=21600
#FLUX: --urgency=16

module load snakemake
snakemake --use-conda --cores 36
