#!/bin/bash
#FLUX: --job-name=loopy-snack-1371
#FLUX: --urgency=16

source /etc/profile
module load julia-latest
module load mpi/mpich-x86_64
mpirun julia top5norm_alltoall.jl
