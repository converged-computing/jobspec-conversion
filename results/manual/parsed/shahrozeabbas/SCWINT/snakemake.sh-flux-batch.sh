#!/bin/bash
#FLUX: --job-name=dirty-cattywampus-0174
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=259200
#FLUX: --priority=16

source /data/abbass2/Apps/conda/bin/activate snakes
snakemake --use-conda --cores 32
