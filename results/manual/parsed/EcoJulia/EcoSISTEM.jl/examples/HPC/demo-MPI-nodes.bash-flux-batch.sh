#!/bin/bash
#FLUX: --job-name=crunchy-squidward-9456
#FLUX: -N=4
#FLUX: -n=32
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='8'

module load apps/julia
module load mpi/openmpi
julia --project=examples -e 'using Pkg; Pkg.instantiate(); Pkg.build("MPI"); using MPI; MPI.install_mpiexecjl(destdir = "bin", force = true)'
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=8
bin/mpiexecjl --project=examples -n 32 julia -t 8 --project=examples examples/HPC/MPIRun.jl
