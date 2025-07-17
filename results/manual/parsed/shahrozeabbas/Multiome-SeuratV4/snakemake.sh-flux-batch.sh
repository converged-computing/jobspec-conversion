#!/bin/bash
#FLUX: --job-name=hello-caramel-7654
#FLUX: -c=36
#FLUX: --queue=largemem
#FLUX: -t=21600
#FLUX: --urgency=16

module load snakemake
snakemake --use-conda --cores 36
