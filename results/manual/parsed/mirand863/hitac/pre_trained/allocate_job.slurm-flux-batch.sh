#!/bin/bash
#FLUX --job-name=joyous-snack-2187
#FLUX --queue=magic
#FLUX -t=432000
#FLUX --urgency=16

snakemake --unlock
snakemake --profile slurm
