#!/bin/bash
#FLUX: --job-name=octavian_job_20
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export JULIA_NUM_THREADS='20 # 20 == single socket'

module reset
export JULIA_NUM_THREADS=20 # 20 == single socket
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_octavian.jl 10240
