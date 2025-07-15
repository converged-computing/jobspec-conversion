#!/bin/bash
#FLUX: --job-name=grated-avocado-0296
#FLUX: --queue=short
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export MKL_ENABLE_INSTRUCTIONS='AVX2'
export JULIA_PROJECT='@.'

set -e
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export MKL_ENABLE_INSTRUCTIONS=AVX2
export JULIA_PROJECT=@.
module load apps/julia/1.6
julia -e 'using Pkg; Pkg.instantiate()'
