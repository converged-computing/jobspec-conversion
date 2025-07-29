#!/bin/bash
#FLUX --job-name=doopy-noodle-9880
#FLUX --queue=cpu2019
#FLUX -t=259200
#FLUX --urgency=16

mkdir -p logs/slurm
snakemake --profile slurm --rerun-incomplete --latency-wait 90
