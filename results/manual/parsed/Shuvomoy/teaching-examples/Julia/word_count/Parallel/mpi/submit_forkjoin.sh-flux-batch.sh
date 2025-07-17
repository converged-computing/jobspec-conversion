#!/bin/bash
#FLUX: --job-name=purple-eagle-2710
#FLUX: -n=4
#FLUX: --urgency=16

source /etc/profile
module load julia-latest
module load mpi/mpich-x86_64
mpirun julia top5norm_forkjoin.jl
