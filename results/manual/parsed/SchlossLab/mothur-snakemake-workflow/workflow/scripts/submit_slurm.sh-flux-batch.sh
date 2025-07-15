#!/bin/bash
#FLUX: --job-name=mothur-demo
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --priority=16

snakemake --use-conda --profile config/slurm --latency-wait 90 --configfile config/demo.yaml
