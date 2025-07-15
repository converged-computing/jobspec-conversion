#!/bin/bash
#FLUX: --job-name=faux-taco-0595
#FLUX: -t=172800
#FLUX: --urgency=16

snakemake --profile profiles/biowulf --verbose -p --use-conda --jobs 400 --use-envmodules --latency-wait 120 -T 0 --configfile $1
