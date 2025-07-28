#!/bin/bash
#FLUX: --job-name=hairy-gato-0576
#FLUX: -n=4
#FLUX: --urgency=16

source /etc/profile
module load julia-latest
module load mpi/mpich-x86_64
mpirun julia top5norm_mresque.jl
