#!/bin/bash
#FLUX: --job-name=loopy-avocado-0953
#FLUX: --queue=cpu2019
#FLUX: -t=259200
#FLUX: --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
