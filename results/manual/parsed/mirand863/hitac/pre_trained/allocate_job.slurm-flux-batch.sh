#!/bin/bash
#FLUX: --job-name=sticky-pot-2109
#FLUX: --queue=magic
#FLUX: -t=432000
#FLUX: --urgency=16

snakemake --unlock
snakemake --profile slurm
