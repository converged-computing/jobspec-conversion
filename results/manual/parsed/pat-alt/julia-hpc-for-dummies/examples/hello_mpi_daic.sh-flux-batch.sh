#!/bin/bash
#FLUX: --job-name=conspicuous-nunchucks-0780
#FLUX: -n=8
#FLUX: --queue=general
#FLUX: -t=60
#FLUX: --urgency=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia hello_mpi.jl > hello_mpi.log
