#!/bin/bash
#FLUX: --job-name=JULIA
#FLUX: --queue=shared
#FLUX: -t=60
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load julia
julia example.jl > result
