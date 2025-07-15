#!/bin/bash
#FLUX: --job-name=red-puppy-4794
#FLUX: -t=3600
#FLUX: --urgency=16

source ~/miniforge3/etc/profile.d/conda.sh
conda activate bioinformatics
GIT_REPO_DIR=/scratch/gpfs/bjarnold/intro_compbio_workflows_2024
snakemake --directory ../ --snakefile ../Snakefile \
--profile ${GIT_REPO_DIR}/snakemake_profiles/slurm
