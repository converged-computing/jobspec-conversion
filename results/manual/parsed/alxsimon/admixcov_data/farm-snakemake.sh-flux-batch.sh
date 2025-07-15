#!/bin/bash
#FLUX: --job-name=lovable-peanut-7128
#FLUX: --urgency=16

module load miniconda3
snakemake --profile farm-profile
