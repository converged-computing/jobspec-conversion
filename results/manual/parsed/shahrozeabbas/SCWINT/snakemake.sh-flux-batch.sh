#!/bin/bash
#FLUX: --job-name=fat-nunchucks-1478
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=259200
#FLUX: --urgency=16

source /data/abbass2/Apps/conda/bin/activate snakes
snakemake --use-conda --cores 32
