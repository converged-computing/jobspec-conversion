#!/bin/bash
#FLUX: --job-name=controljob_%j
#FLUX: --queue=longrun
#FLUX: -t=172800
#FLUX: --urgency=16

SNAKEMAKE_ENV='snakemake'
eval "$(conda shell.bash hook)"
conda activate ${SNAKEMAKE_ENV}
snakemake --snakefile workflow/Snakefile \
          --profile ./slurm \
          --directory "${PWD}" \
          "${@}"
