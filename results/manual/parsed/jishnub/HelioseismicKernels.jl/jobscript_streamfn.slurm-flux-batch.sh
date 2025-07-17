#!/bin/bash
#FLUX: --job-name=ttstrmfn
#FLUX: -n=56
#FLUX: -t=3600
#FLUX: --urgency=16

cd $SCRATCH/jobs
julia="$PROJECT/julia-1.6.1/bin/julia"
module purge
module load openmpi
$julia -e 'include("$(ENV["HOME"])/HelioseismicKernels/streamfn_traveltimes.jl")'
