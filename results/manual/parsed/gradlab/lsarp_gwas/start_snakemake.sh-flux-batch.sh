#!/bin/bash
#FLUX --job-name=buttery-underoos-9557
#FLUX --queue=cpu2021
#FLUX -t=86400
#FLUX --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
