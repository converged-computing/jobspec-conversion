#!/bin/bash
#FLUX: --job-name=hairy-blackbean-7678
#FLUX: --priority=16

module load miniconda3
snakemake --profile farm-profile
