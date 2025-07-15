#!/bin/bash
#FLUX: --job-name=expensive-salad-9050
#FLUX: -n=16
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia -p15 TCRunner.jl "$@"
echo finished
