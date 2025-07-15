#!/bin/bash
#FLUX: --job-name=carnivorous-arm-3979
#FLUX: -t=720000
#FLUX: --priority=16

export TMPDIR='TMP'

mkdir -p TMP
export TMPDIR=TMP
module load singularity 
snakemake --skip-script-cleanup -k  --keep-incomplete --rerun-incomplete --profile workflow/profiles/biowulf --verbose -p --use-conda --jobs 400 --use-singularity --use-envmodules --latency-wait 600 -T 0 -s Snakefile_CGRv2
