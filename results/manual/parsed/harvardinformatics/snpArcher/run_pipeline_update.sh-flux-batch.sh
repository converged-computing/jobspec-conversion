#!/bin/bash
#FLUX: --job-name=lovely-banana-2905
#FLUX: --priority=16

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate snakemake
snakemake -R $(snakemake --list-params-changes) --snakefile workflow/Snakefile --profile ./profiles/slurm
