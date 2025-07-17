#!/bin/bash
#FLUX: --job-name=outstanding-nalgas-9193
#FLUX: -n=2
#FLUX: -c=32
#FLUX: --queue=nodes
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='32'

module load apps/julia
module load mpi/openmpi
julia --project=examples -e 'using Pkg; Pkg.instantiate(); Pkg.build("MPI"); using MPI; MPI.install_mpiexecjl(destdir = "bin", force = true)'
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=32
bin/mpiexecjl --project=examples -n 2 julia -t 32 --project=examples examples/HPC/MPIRun.jl
