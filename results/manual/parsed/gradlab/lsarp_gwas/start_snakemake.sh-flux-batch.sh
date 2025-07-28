#!/bin/bash
#FLUX: --job-name=outstanding-noodle-8100
#FLUX: --queue=cpu2021
#FLUX: -t=86400
#FLUX: --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
