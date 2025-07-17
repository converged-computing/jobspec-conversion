#!/bin/bash
#FLUX: --job-name=hairy-avocado-2067
#FLUX: --queue=magic
#FLUX: -t=432000
#FLUX: --urgency=16

snakemake --unlock
snakemake --profile slurm
