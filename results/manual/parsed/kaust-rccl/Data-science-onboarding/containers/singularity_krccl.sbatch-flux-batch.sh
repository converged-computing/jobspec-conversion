#!/bin/bash
#FLUX: --job-name=crusty-buttface-1084
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITY_TMPDIR='/ibex/user/$USER/TMPDIR'
export SINGULARITY_CACHEDIR='/ibex/user/$USER/singularity_cache'

module load singularity
mkdir -p /ibex/user/$USER/singularity_cache /ibex/user/$USER/TMPDIR
export SINGULARITY_TMPDIR=/ibex/user/$USER/TMPDIR
export SINGULARITY_CACHEDIR=/ibex/user/$USER/singularity_cache
singularity build -f --force $PWD/horovod_krccl.sif $PWD/horovod_krccl.def
