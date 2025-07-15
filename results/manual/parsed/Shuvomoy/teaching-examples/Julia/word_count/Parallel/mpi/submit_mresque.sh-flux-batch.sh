#!/bin/bash
#FLUX: --job-name=stanky-malarkey-4293
#FLUX: --urgency=16

source /etc/profile
module load julia-latest
module load mpi/mpich-x86_64
mpirun julia top5norm_mresque.jl
