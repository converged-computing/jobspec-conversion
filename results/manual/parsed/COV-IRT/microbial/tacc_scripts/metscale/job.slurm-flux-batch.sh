#!/bin/bash
#FLUX: --job-name=nerdy-punk-8568
#FLUX: --priority=16

export SINGULARITY_BINDPATH='data:/tmp'

module load tacc-singularity
module list
umask 0007
conda activate metag
export SINGULARITY_BINDPATH="data:/tmp"
snakemake --cores --use-singularity --configfile=config/my_custom_config.json tax_class_bracken_workflow > snakemake.${SLURM_JOBID}.log 2>&1
