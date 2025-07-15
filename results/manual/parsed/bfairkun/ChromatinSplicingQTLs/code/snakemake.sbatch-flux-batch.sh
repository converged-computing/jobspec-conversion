#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=broadwl
#FLUX: -t=115200
#FLUX: --urgency=16

snakemake --profile snakemake_profiles/slurm
