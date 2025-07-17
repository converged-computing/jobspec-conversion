#!/bin/bash
#FLUX: --job-name=sticky-fudge-6635
#FLUX: -n=4
#FLUX: --urgency=16

module load julia/1.7.3
module load mpi/openmpi-4.1.3
mpirun julia top5norm_forkjoin.jl
