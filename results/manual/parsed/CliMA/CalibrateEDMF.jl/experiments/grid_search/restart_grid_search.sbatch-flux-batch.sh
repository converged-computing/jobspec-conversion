#!/bin/bash
#FLUX: --job-name=moolicious-chip-6493
#FLUX: -n=25
#FLUX: -t=108000
#FLUX: --urgency=16

outdir=${1?Error: no output directory given}
module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia --project -p 25 grid_search.jl --outdir $outdir --mode restart
