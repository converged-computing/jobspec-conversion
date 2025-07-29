#!/bin/bash
#FLUX: --job-name=snakemake_rnaseq
#FLUX: -c=30
#FLUX: -t=86400
#FLUX: --urgency=16

source activate rnaseq
srun snakemake -j $SLURM_CPUS_PER_TASK
