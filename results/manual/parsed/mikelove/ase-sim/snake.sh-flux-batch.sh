#!/bin/bash
#FLUX: --job-name=snake
#FLUX: -t=14400
#FLUX: --priority=16

snakemake -j 10 --rerun-triggers mtime --latency-wait 30 --cluster "sbatch --mem=5000 -N 1 -n 12 --time=60"
