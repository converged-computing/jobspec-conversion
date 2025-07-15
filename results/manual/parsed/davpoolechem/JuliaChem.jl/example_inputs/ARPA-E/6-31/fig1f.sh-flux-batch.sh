#!/bin/bash
#FLUX: --job-name=example_inputs/ARPA-E/6-31/fig1f
#FLUX: --queue=compute
#FLUX: --priority=16

export JULIA_NUM_THREADS='1'
export OMP_NUM_THREADS='1'

export JULIA_NUM_THREADS=1
export OMP_NUM_THREADS=1
mpirun -np 1 julia --check-bounds=no --math-mode=fast --optimize=3 --inline=yes --compiled-modules=yes example_scripts/minimal-rhf.jl example_inputs/ARPA-E/6-31/fig1f.json
