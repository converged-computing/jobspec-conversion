#!/bin/bash
#FLUX: --job-name=carnivorous-banana-7233
#FLUX: -c=128
#FLUX: --queue=smp
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='128'

module load apps/julia
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=128
julia -t 128 --project=examples examples/Africa_run.jl
