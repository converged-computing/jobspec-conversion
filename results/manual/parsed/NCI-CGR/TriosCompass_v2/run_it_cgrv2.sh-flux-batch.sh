#!/bin/bash
#FLUX: --job-name=tart-itch-5698
#FLUX: -t=720000
#FLUX: --urgency=16

export TMPDIR='TMP'

mkdir -p TMP
export TMPDIR=TMP
module load singularity 
snakemake --skip-script-cleanup -k  --keep-incomplete --rerun-incomplete --profile workflow/profiles/biowulf --verbose -p --use-conda --jobs 400 --use-singularity --use-envmodules --latency-wait 600 -T 0 -s Snakefile_CGRv2
