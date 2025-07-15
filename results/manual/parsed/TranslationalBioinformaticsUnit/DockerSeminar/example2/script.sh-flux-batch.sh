#!/bin/bash
#FLUX: --job-name=delicious-ricecake-2690
#FLUX: --priority=16

export SINGULARITY_TMPDIR='/ibex/user/$USER/singularity/tmpdir'

mkdir -p /ibex/user/$USER/singularity/tmpdir
export SINGULARITY_TMPDIR=/ibex/user/$USER/singularity/tmpdir
module load singularity
singularity build --fakeroot --force singularityexample.sig singularityexample.def
singularity run /home/ruizdeam/singularityexample.sig
