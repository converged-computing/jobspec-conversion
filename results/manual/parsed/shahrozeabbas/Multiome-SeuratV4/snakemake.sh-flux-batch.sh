#!/bin/bash
#FLUX: --job-name=eccentric-pastry-5924
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=21600
#FLUX: --urgency=16

module load snakemake
snakemake --use-conda --cores 36
