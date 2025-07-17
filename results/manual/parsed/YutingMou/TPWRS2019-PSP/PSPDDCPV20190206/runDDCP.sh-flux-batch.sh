#!/bin/bash
#FLUX: --job-name=DDCP
#FLUX: -n=24
#FLUX: -t=16200
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --depwarn=no --machinefile $SLURM_NODEFILE ./source/Main.jl
