#!/bin/bash
#FLUX: --job-name=mikropml # sbatch options here only affect the overall job
#FLUX: --queue=standard             # the partition
#FLUX: -t=345600
#FLUX: --priority=16

module load singularity 
snakemake --profile config/slurm --latency-wait 90 --use-singularity --use-conda --conda-frontend mamba --configfile config/test.yaml 
