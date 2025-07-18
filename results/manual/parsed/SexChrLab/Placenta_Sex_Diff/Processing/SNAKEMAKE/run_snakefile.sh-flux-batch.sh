#!/bin/bash
#FLUX: --job-name=GZ_fastq
#FLUX: -n=6
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake --snakefile Snakefile -j 30 --nolock --latency-wait 15 --rerun-incomplete --cluster "sbatch -n 1 --nodes 1 -c 8 -t 04:00:00"
