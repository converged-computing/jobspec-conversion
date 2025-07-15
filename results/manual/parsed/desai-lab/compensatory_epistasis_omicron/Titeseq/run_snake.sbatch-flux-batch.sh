#!/bin/bash
#FLUX: --job-name=frigid-fudge-9547
#FLUX: -n=48
#FLUX: --priority=16

module load python/3.7.7-fasrc01
source activate omicron
snakemake -j 48
