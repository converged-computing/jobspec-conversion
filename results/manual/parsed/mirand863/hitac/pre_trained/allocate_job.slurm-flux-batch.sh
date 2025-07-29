#!/bin/bash
#FLUX --job-name=creamy-knife-0661
#FLUX --queue=magic
#FLUX -t=432000
#FLUX --urgency=16

snakemake --unlock
snakemake --profile slurm
