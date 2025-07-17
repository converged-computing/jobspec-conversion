#!/bin/bash
#FLUX: --job-name=cowy-bicycle-4029
#FLUX: --queue=cpu2019
#FLUX: -t=259200
#FLUX: --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
