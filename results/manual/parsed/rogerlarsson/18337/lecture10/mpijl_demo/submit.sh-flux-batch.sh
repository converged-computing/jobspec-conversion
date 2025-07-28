#!/bin/bash
#FLUX: --job-name=sticky-blackbean-7816
#FLUX: -n=4
#FLUX: --urgency=16

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
