#!/bin/bash
#FLUX: --job-name=wobbly-hobbit-4672
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=21600
#FLUX: --priority=16

module load snakemake
snakemake --use-conda --cores 36
