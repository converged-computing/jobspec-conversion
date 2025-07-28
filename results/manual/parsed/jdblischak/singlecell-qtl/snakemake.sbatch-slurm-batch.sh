#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=gilad
#FLUX: -t=86400
#FLUX: --urgency=16

source activate scqtl
bash submit-snakemake.sh $*
