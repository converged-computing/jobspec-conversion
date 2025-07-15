#!/bin/bash
#FLUX: --job-name=doopy-cat-7620
#FLUX: -n=10
#FLUX: -t=7200
#FLUX: --urgency=16

config=${1?Error: no config file given}
module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia --project -p 10 calibrate.jl --config $config
