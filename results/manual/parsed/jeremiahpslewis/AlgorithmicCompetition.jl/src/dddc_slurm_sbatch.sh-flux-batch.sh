#!/bin/bash
#FLUX: --job-name=array_job
#FLUX: --queue=normal
#FLUX: -t=173520
#FLUX: --urgency=16

export N_ITERATIONS='1 '
export DEBUG='0'
export VERSION='2024-05-22-debug'

export N_ITERATIONS=1 
export DEBUG=0
export VERSION="2024-05-22-debug"
julia --project=. src/dddc_slurm_batch.jl
