#!/bin/bash
#FLUX: --job-name=evasive-frito-1661
#FLUX: -n=4
#FLUX: --urgency=16

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
