#!/bin/bash
#FLUX: --job-name=juliachem-runtest
#FLUX: -c=16
#FLUX: --queue=haswell
#FLUX: --urgency=16

export JULIA_NUM_THREADS='16'

export JULIA_NUM_THREADS=16
julia --check-bounds=no --math-mode=fast --optimize=3 --inline=yes --compiled-modules=yes -E 'using Pkg; using JuliaChem; Pkg.test("JuliaChem")'
