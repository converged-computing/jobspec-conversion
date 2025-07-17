#!/bin/bash
#FLUX: --job-name=reclusive-cinnamonbun-3686
#FLUX: -n=8
#FLUX: --queue=priority
#FLUX: -t=86400
#FLUX: --urgency=16

module load conda2/4.2.13
source activate snakemake
snakemake --use-conda -j 8 some_rule
