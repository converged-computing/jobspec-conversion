#!/bin/bash
#FLUX: --job-name=chocolate-lemon-3124
#FLUX: -n=48
#FLUX: --urgency=16

module load python/3.7.7-fasrc01
source activate omicron
snakemake -j 48
