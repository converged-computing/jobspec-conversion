#!/bin/bash
#FLUX: --job-name=MinnowTraits
#FLUX: -t=10800
#FLUX: --urgency=16

export SBATCH_ACCOUNT='$SLURM_JOB_ACCOUNT'

export SBATCH_ACCOUNT=$SLURM_JOB_ACCOUNT
NUM_JOBS=20
module load miniconda3/4.10.3-py37
source activate snakemake
snakemake \
    --jobs $NUM_JOBS \
    --use-singularity \
    --singularity-args "--bind $HOME/.dataverse" \
    "$@"
