#!/bin/bash
#FLUX: --job-name=nerdy-knife-6532
#FLUX: -n=25
#FLUX: -t=108000
#FLUX: --urgency=16

config=${1?Error: no config file given}
module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia --project -p 25 grid_search.jl --config $config --mode new
