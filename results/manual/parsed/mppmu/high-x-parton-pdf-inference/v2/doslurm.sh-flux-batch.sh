#!/bin/bash
#FLUX: --job-name=bricky-ricecake-2240
#FLUX: -t=172800
#FLUX: --priority=16

export SINGULARITY_TMPDIR='$(pwd)/tmp'
export SINGULARITY_CACHEDIR='$(pwd)/tmp'

module purge
module load apptainer
export SINGULARITY_TMPDIR=$(pwd)/tmp
export SINGULARITY_CACHEDIR=$(pwd)/tmp
set -x
mkdir -p CABCHSV fitresults pseudodata
srun  singularity exec -B $(pwd):$(pwd) --env JULIA_DEPOT_PATH=$(pwd)/J:/opt/julia docker://ghcr.io/mppmu/high-x-parton-pdf-inference:latest $JULIA  "$@"
