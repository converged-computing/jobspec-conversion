#!/bin/bash
#FLUX: --job-name=creamy-lettuce-5635
#FLUX: --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
