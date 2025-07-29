#!/bin/bash
#SBATCH --job-name=MinnowTraits
#SBATCH --account=PAS2136
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

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
