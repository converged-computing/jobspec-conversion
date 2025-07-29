#!/bin/bash
#FLUX --job-name=loopy-lettuce-0895
#FLUX -t=18000
#FLUX --urgency=16

snakemake_start
snakemake -s /path/to/snakefile -profile oscar
snakemake -s ${HOME}/snakemake_tutorial/tutorial.nf -profile oscar 
