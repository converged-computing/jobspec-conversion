#!/bin/bash
#FLUX: --job-name=milky-lamp-9826
#FLUX: -c=10
#FLUX: -t=21600
#FLUX: --urgency=16

module load Julia
echo "Julia module loaded."
julia --project=. -e 'include("test.jl")'
echo "Julia test passed."
julia --project=. -e 'import Pkg; Pkg.instantiate(); include("src/run.jl")'
