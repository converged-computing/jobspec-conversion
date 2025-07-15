#!/bin/bash
#FLUX: --job-name=swampy-noodle-4567
#FLUX: --urgency=16

module load miniconda3
snakemake --profile farm-profile
