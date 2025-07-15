#!/bin/bash
#FLUX: --job-name=goodbye-pancake-9749
#FLUX: --priority=16

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
