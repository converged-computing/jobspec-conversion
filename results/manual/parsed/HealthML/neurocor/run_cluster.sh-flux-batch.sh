#!/bin/bash
#FLUX: --job-name=controljob_%j
#FLUX: --queue=vcpu,hpcpu
#FLUX: -t=86400
#FLUX: --priority=16

SNAKEMAKE_ENV=snakemake
eval "$(conda shell.bash hook)"
conda activate ${SNAKEMAKE_ENV}
snakemake --snakefile workflow/Snakefile \
          --configfile config/config.yaml \
	  --profile ./slurm \
          --rerun-triggers mtime \
          --directory "${PWD}" \
	  "${@}"
