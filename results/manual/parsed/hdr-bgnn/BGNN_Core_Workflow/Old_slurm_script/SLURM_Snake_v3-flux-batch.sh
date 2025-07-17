#!/bin/bash
#FLUX: --job-name=segment_test
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

set -e
SNAKEFILE=$1
WORKDIR=$2
module load miniconda3/4.10.3-py37
source activate snakemake
snakemake \
    --cores $SLURM_NTASKS \
    --snakefile $SNAKEFILE \
    --use-conda \
    --directory $WORKDIR \
chmod -R 774 $WORKDIR
