#!/bin/bash
#FLUX: --job-name=anxious-butter-7992
#FLUX: --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
