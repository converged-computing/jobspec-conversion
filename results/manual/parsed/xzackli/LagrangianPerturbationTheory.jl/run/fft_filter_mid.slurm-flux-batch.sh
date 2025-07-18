#!/bin/bash
#FLUX: --job-name=mid_filter
#FLUX: -N=16
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export JULIA_NUM_THREADS='8'

cd /pscratch/sd/x/xzackli/websky_convert/LagrangianPerturbationTheory.jl/run/
module load cray-mpich
module load cray-hdf5-parallel
export JULIA_NUM_THREADS=8
which julia
julia --project=. -e \
    'using Pkg; using InteractiveUtils;
     Pkg.instantiate(); Pkg.precompile(); Pkg.status(); versioninfo();
     using MPI; println("MPI: ", MPI.identify_implementation());'
/global/homes/x/xzackli/.julia/bin/mpiexecjl --project=. --cpu-bind=cores julia fft_filter_6144.jl
