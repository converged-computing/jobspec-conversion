#!/bin/bash
#FLUX: --job-name=bosonstar
#FLUX: --queue=multi
#FLUX: -t=86400
#FLUX: --urgency=16

export JULIA_NUM_THREADS='64'
export SLURM_HINT='multithread '

export JULIA_NUM_THREADS=64
export SLURM_HINT=multithread 
julia --project=BosonStars main.jl
