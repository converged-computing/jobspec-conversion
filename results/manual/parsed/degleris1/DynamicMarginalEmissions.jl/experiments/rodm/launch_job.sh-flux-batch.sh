#!/bin/bash
#FLUX: --job-name=carbon_rodm
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

SCIPT_DIR=/home/users/degleris/CarbonNetworks.jl/experiments/rodm/
srun hostname
module load julia
srun julia -t 8 ${SCIPT_DIR}${1}
