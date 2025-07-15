#!/bin/bash
#FLUX: --job-name=fugly-bicycle-7191
#FLUX: --priority=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
