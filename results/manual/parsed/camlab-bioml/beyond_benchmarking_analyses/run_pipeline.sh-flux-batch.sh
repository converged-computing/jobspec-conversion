#!/bin/bash
#FLUX: --job-name=evasive-chip-7756
#FLUX: -t=0
#FLUX: --urgency=16

source ~/env/bin/activate
module load singularity
snakemake -s ~/automl_scrna/scripts/automl_snakefile --unlock --jobs 50 --use-singularity --profile ~/slurm
snakemake -s ~/automl_scrna/scripts/automl_snakefile --rerun-incomplete  --jobs 50 -k  --use-singularity --profile ~/slurm 
