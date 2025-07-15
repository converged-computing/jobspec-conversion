#!/bin/bash
#FLUX: --job-name=eccentric-caramel-6560
#FLUX: --priority=16

source /etc/profile
module load julia-latest
module load mpi/mpich-x86_64
mpirun julia top5norm_mresque.jl
