#!/bin/bash
#FLUX: --job-name=benchmark
#FLUX: -t=86400
#FLUX: --priority=16

module load diffexp/1.0
snakemake --cores 20 -s snakefile-benchmark 
