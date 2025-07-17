#!/bin/bash
#FLUX: --job-name=kernel
#FLUX: -n=224
#FLUX: -t=21600
#FLUX: --urgency=16

cd $SCRATCH/jobs
module purge
module load openmpi
julia="$PROJECT/julia-1.6.1/bin/julia"
mpirun $julia -e 'const HOME = ENV["HOME"]; include("$HOME/HelioseismicKernels/computekernel.jl")'
