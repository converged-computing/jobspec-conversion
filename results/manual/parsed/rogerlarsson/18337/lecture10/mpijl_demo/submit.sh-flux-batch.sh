#!/bin/bash
#FLUX: --job-name=peachy-egg-7747
#FLUX: -n=4
#FLUX: --urgency=16

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
