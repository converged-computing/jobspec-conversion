#!/bin/bash
#FLUX: --job-name=bricky-chip-1166
#FLUX: --queue=magic
#FLUX: -t=432000
#FLUX: --urgency=16

snakemake --unlock
snakemake --profile slurm
