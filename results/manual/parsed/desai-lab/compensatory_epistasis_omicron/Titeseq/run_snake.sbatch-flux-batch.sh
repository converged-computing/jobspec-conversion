#!/bin/bash
#FLUX: --job-name=RBD_abecgivdhjx
#FLUX: -n=48
#FLUX: --queue=desai
#FLUX: -t=720
#FLUX: --urgency=16

module load python/3.7.7-fasrc01
source activate omicron
snakemake -j 48
