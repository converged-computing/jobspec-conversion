#!/bin/bash
#FLUX: --job-name=Ndopt
#FLUX: -t=72000
#FLUX: --priority=16

export PATH='~/Applications/julia-1.6.2/bin:$PATH'
export LD_LIBRARY_PATH='~/Applications/julia-1.6.2/lib'

export PATH=~/Applications/julia-1.6.2/bin:$PATH
export LD_LIBRARY_PATH=~/Applications/julia-1.6.2/lib
cd /home/geovault-06/pasquier/Projects/GNOM
julia src/Nd_model/setup_and_optimization.jl
