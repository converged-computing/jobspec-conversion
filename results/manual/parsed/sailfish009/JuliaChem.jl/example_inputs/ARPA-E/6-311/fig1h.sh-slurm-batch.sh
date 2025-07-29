#!/bin/bash
#FLUX: --job-name=example_inputs/ARPA-E/6-311/fig1h
#FLUX: -c=8
#FLUX: --queue=haswell
#FLUX: --urgency=16

export JULIA_NUM_THREADS='8'
export OMP_NUM_THREADS='8'

export JULIA_NUM_THREADS=8
export OMP_NUM_THREADS=8
mpirun -np 1 julia --check-bounds=no --math-mode=fast --optimize=3 --inline=yes --compiled-modules=yes example_scripts/minimal-rhf-benchmark.jl example_inputs/ARPA-E/6-311/fig1h.json
