#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=partition_name
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda3
source activate peakcalling
bash Submit_snakemake.sh "-s Snakefile" "--configfile config.yaml" $*
