#!/bin/bash
#FLUX: --job-name=mackey
#FLUX: -N=2
#FLUX: --queue=standard
#FLUX: --urgency=16

module load julia/1.5.3
module load hpc
julia comm_mackey_ensemble.jl
