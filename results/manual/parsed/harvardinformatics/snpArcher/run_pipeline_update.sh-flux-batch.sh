#!/bin/bash
#FLUX: --job-name=sm
#FLUX: --queue=shared
#FLUX: -t=540000
#FLUX: --urgency=16

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate snakemake
snakemake -R $(snakemake --list-params-changes) --snakefile workflow/Snakefile --profile ./profiles/slurm
