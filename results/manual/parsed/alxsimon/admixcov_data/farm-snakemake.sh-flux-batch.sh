#!/bin/bash
#FLUX: --job-name=goodbye-fork-2348
#FLUX: --priority=16

module load miniconda3
snakemake --profile farm-profile
