#!/bin/bash
#FLUX: --job-name=Run an UltraDark test simulation
#FLUX: -n=32
#FLUX: -t=600
#FLUX: --urgency=16

export JULIA_DEBUG='UltraDark'

module load openmpi/4.0.4-gcc-4.8.5
module load hdf5/1.12.0-openmpi-4.0.4-gcc-4.8.5
module load fftw3/3.3.8-openmpi-4.0.4-gcc-4.8.5
PATH=$PATH:~/julia-1.6.1/bin/
echo "Building MPI.jl" >&2
julia --project -e 'ENV["JULIA_MPI_BINARY"]="system"; using Pkg; Pkg.build("MPI"; verbose=true)'
echo "Running simulation" >&2
export JULIA_DEBUG=UltraDark
mpirun julia --project ../soliton_velocity.jl
echo "Job done" >&2
