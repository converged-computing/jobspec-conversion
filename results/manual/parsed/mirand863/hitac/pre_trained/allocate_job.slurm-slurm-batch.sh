#!/bin/bash
#FLUX: --job-name=purple-sundae-0407
#FLUX: --queue=magic
#FLUX: -t=432000
#FLUX: --urgency=16

snakemake --unlock
snakemake --profile slurm
