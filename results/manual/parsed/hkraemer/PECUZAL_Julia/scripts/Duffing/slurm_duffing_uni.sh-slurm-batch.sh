#!/bin/bash
#FLUX: --job-name=duf_u
#FLUX: -N=2
#FLUX: --queue=standard
#FLUX: --urgency=16

module load julia/1.5.3
module load hpc
julia comm_duffing_ensemble_uni.jl
