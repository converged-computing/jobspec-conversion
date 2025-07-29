#!/bin/bash
#FLUX: --job-name=JL.p.weyl
#FLUX: -n=128
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH=' '
export LD_PRELOAD=''
export JULIA_NUM_THREADS='ntot'
export DISPLAY=':1'

n=128 # number of tasks per node
N=1 # number of tasks
ntot=$((n * N))
export LD_LIBRARY_PATH="" 
export LD_PRELOAD=""
export JULIA_NUM_THREADS=ntot
vncserver
export DISPLAY=:1
julia runs.jl
