#!/bin/bash
#FLUX: --job-name=OptiFit
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

time snakemake --profile config/slurm --latency-wait 90
