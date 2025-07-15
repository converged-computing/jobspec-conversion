#!/bin/bash
#FLUX: --job-name=compile_PerforatedCylinder
#FLUX: --urgency=16

source modules_snellius.sh
julia --project=../ -e 'using Pkg; Pkg.build("MPI")'
mpiexecjl --project=../ -n 1 julia -O3 --check-bounds=no --color=yes compile_genoa.jl
