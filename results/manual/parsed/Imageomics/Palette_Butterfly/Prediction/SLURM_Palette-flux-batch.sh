#!/bin/bash
#FLUX: --job-name=segment_test
#FLUX: -n=4
#FLUX: -t=1200
#FLUX: --priority=16

set -e
WORKDIR=$1
module load miniconda3/4.10.3-py37
source activate snakemake
snakemake \
    --cores $SLURM_NTASKS \
    --use-singularity \
    --directory $WORKDIR \
chmod -R 774 $WORKDIR
