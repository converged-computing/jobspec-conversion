#!/bin/bash
#FLUX: --job-name=quirky-sundae-8252
#FLUX: --queue=standard
#FLUX: -t=129600
#FLUX: --urgency=16

CONFIG='config/cluster'
CORES=36
conda env export > environment.yml
cp Snakefile workflow.smk
snakemake --profile ${CONFIG} --use-conda --cores ${CORES} --rerun-incomplete --latency-wait 90 --verbose -s workflow.smk 
