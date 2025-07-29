#!/bin/bash
#FLUX: --job-name=Run an UltraDark test simulation
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=600
#FLUX: --urgency=16

module load openmpi
module load fftw3
PATH=$PATH:~/julia-1.6.1/bin/
julia --project -e 'ENV["JULIA_MPI_BINARY"]="system"; using Pkg; Pkg.build("MPI"; verbose=true)'
mpiexec julia --project ../soliton_velocity.jl
