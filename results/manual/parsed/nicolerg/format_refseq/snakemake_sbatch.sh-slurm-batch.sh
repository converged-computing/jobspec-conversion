#!/bin/bash
#FLUX: --job-name=format_refseq
#FLUX: -c=12
#FLUX: --queue=interactive
#FLUX: -t=432000
#FLUX: --urgency=16

module load r/3.6
snakemake -j 12 --latency-wait=90
