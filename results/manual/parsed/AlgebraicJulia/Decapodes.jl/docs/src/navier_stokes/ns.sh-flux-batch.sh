#!/bin/bash
#FLUX: --job-name=NS
#FLUX: -c=16
#FLUX: -t=28800
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='/blue/fairbanksj/fairbanksj/jldepot'

pwd; hostname; date
module load julia
mkdir -p "/blue/fairbanksj/fairbanksj/jldepot"
export JULIA_DEPOT_PATH="/blue/fairbanksj/fairbanksj/jldepot"
echo "JULIA_DEPOT_PATH:"
echo "$JULIA_DEPOT_PATH"
echo "Launching script"
date
julia --threads=auto --proj=. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
julia --threads=auto --proj=. ./ns.jl
date
echo "Exiting script"
