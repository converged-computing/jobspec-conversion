#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: -t=54000
#FLUX: --urgency=16

export N_ITERATIONS='1 '
export DEBUG='1'
export VERSION='2024-05-22-debug'

export N_ITERATIONS=1 
export DEBUG=1
export VERSION="2024-05-22-debug"
julia --project=. src/aiapc_slurm_batch.jl
