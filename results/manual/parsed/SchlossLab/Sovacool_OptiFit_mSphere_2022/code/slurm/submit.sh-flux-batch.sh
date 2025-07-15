#!/bin/bash
#FLUX: --job-name=OptiFit
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --priority=16

time snakemake --profile config/slurm --latency-wait 90
