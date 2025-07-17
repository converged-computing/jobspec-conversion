#!/bin/bash
#FLUX: --job-name=benchmark
#FLUX: --queue=long-40core
#FLUX: -t=86400
#FLUX: --urgency=16

module load diffexp/1.0
snakemake --cores 20 -s snakefile-benchmark 
