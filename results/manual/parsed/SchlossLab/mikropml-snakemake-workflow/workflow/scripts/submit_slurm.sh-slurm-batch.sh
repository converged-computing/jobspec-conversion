#!/bin/bash
#FLUX: --job-name=mikropml
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

module load singularity 
snakemake --profile config/slurm --latency-wait 90 --use-singularity --use-conda --conda-frontend mamba --configfile config/test.yaml 
