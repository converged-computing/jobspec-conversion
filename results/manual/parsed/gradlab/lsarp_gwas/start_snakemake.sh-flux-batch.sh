#!/bin/bash
#FLUX: --job-name=gassy-rabbit-0086
#FLUX: --priority=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
