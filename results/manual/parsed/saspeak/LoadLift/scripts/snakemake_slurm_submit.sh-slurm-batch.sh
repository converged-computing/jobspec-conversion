#!/bin/bash
#FLUX: --job-name=Snakemake_submission
#FLUX: -n=2
#FLUX: --queue=medium
#FLUX: -t=86400
#FLUX: --urgency=16

source activate snakemake
snakemake --slurm --default-resources slurm_account=cropdiv-acc slurm_partition=short -s ${1} ${3} -j ${2} --use-conda --rerun-incomplete 
source deactivate
