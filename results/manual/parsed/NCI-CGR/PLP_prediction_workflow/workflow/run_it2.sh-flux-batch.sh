#!/bin/bash
#FLUX: --job-name=misunderstood-kitty-8577
#FLUX: -t=172800
#FLUX: --priority=16

snakemake --profile profiles/biowulf --verbose -p --use-conda --jobs 400 --use-envmodules --latency-wait 120 -T 0 --configfile $1
