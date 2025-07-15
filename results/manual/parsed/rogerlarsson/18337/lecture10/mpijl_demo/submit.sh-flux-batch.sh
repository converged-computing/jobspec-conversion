#!/bin/bash
#FLUX: --job-name=purple-chip-1144
#FLUX: --urgency=16

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
