#!/bin/bash
#FLUX: --job-name=bloated-chair-3409
#FLUX: --exclusive
#FLUX: --priority=16

export JULIA_NUM_THREADS='20 # 20 == single socket'

module reset
export JULIA_NUM_THREADS=20 # 20 == single socket
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_octavian.jl 10240
