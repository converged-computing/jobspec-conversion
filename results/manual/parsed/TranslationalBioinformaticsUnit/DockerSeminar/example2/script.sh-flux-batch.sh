#!/bin/bash
#FLUX: --job-name=stanky-peas-7658
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_TMPDIR='/ibex/user/$USER/singularity/tmpdir'

mkdir -p /ibex/user/$USER/singularity/tmpdir
export SINGULARITY_TMPDIR=/ibex/user/$USER/singularity/tmpdir
module load singularity
singularity build --fakeroot --force singularityexample.sig singularityexample.def
singularity run /home/ruizdeam/singularityexample.sig
