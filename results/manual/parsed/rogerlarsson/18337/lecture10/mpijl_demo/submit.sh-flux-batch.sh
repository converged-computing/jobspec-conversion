#!/bin/bash
#FLUX: --job-name=evasive-eagle-7334
#FLUX: --priority=16

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
