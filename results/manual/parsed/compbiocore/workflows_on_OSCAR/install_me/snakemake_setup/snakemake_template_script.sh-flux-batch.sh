#!/bin/bash
#FLUX: --job-name=frigid-earthworm-2093
#FLUX: -t=18000
#FLUX: --priority=16

snakemake_start
snakemake -s /path/to/snakefile -profile oscar
snakemake -s ${HOME}/snakemake_tutorial/tutorial.nf -profile oscar 
