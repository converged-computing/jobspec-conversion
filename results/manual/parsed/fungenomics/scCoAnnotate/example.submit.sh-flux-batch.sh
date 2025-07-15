#!/bin/bash
#FLUX: --job-name=scCoAnnotate
#FLUX: -c=5
#FLUX: -t=86400
#FLUX: --priority=16

module load scCoAnnotate/2.0
snakefile=<path to snakefile>
config=<path to configfile>
snakemake -s ${snakefile} --configfile ${config} --unlock 
snakemake -s ${snakefile} --configfile ${config} --cores 5
