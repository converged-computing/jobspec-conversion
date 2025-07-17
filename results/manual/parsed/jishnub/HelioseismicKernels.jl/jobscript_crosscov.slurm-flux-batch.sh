#!/bin/bash
#FLUX: --job-name=cc
#FLUX: -n=56
#FLUX: -t=600
#FLUX: --urgency=16

cd $SCRATCH/jobs
module purge
module load openmpi
julia="$PROJECT/julia-1.6.1/bin/julia"
mpirun $julia -e 'const HOME = ENV["HOME"]; include("$HOME/HelioseismicKernels/computecrosscov.jl")'
