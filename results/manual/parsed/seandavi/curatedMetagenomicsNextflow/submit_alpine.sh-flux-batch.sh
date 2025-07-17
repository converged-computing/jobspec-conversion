#!/bin/bash
#FLUX: --job-name=phat-ricecake-1638
#FLUX: -c=16
#FLUX: --urgency=16

export GOOGLE_APPLICATION_CREDENTIALS='$HOME/omicidx-338300-cbd1527c319e.json'
export NXF_MODE='google'

set -x
echo "working in $SLURM_SCRATCH"
cp main.nf $SLURM_SCRATCH
cp nextflow.config $SLURM_SCRATCH
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/omicidx-338300-cbd1527c319e.json
module load singularity
module load git
module load nextflow
cd $SLURM_SCRATCH
export NXF_MODE=google
nextflow run main.nf --run_ids=$1 --sample_id=$2 -profile alpine
