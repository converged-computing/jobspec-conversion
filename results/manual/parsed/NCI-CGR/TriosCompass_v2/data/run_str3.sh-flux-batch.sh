#!/bin/bash
#FLUX: --job-name=crusty-general-0891
#FLUX: -t=720000
#FLUX: --urgency=16

snakemake --verbose --skip-script-cleanup -k  --rerun-incomplete --profile workflow/profiles/biowulf --verbose -p --use-conda --jobs 400 --use-singularity --use-envmodules --latency-wait 120 -T 0  -s Snakefile_STR3
