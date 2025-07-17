#!/bin/bash
#FLUX: --job-name=main_admixcov_sims
#FLUX: --queue=high2
#FLUX: -t=864000
#FLUX: --urgency=16

module load miniconda3
snakemake --profile farm-profile
