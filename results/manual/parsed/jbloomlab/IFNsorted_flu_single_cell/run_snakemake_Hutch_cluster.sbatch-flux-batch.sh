#!/bin/bash
#FLUX: --job-name=lovely-blackbean-0382
#FLUX: --urgency=16

snakemake -j 10 --cluster "sbatch -p largenode -c 16 --mem=100000 -t 2-0" --latency-wait 30
