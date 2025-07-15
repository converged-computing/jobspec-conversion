#!/bin/bash
#FLUX: --job-name=mpi_ec
#FLUX: -N=2
#FLUX: -t=300
#FLUX: --priority=16

module load gahpc
srun julia -p auto -L ./src/gahpc.jl
