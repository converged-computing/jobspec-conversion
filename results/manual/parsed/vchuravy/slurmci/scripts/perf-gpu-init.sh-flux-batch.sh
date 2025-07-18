#!/bin/bash
#FLUX: --job-name=persnickety-frito-5689
#FLUX: -t=3600
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='$(pwd)/.slurmdepot/gpu'
export OPENBLAS_NUM_THREADS='1'
export PATH='/groups/esm/common/julia-1.3:$PATH'

set -euo pipefail
set -x #echo on
cd ${CI_SRCDIR}
export JULIA_DEPOT_PATH="$(pwd)/.slurmdepot/gpu"
export OPENBLAS_NUM_THREADS=1
export PATH="/groups/esm/common/julia-1.3:$PATH"
module load cuda/10.0 openmpi/4.0.1_cuda-10.0
julia --color=no --project -e 'using Pkg; pkg"instantiate"; pkg"build"; pkg"precompile"'
