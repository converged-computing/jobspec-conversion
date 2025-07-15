#!/bin/bash
#FLUX: --job-name=hello-train-4483
#FLUX: -t=2700
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='$(pwd)/.slurmdepot/gpu'
export OPENBLAS_NUM_THREADS='1'
export PATH='/groups/esm/common/julia-1.3:$PATH'
export TEST_NAME='$(basename "$1")'

set -euo pipefail
set -x #echo on
cd ${CI_SRCDIR}
export JULIA_DEPOT_PATH="$(pwd)/.slurmdepot/gpu"
export OPENBLAS_NUM_THREADS=1
export PATH="/groups/esm/common/julia-1.3:$PATH"
module load cuda/10.0 openmpi/4.0.1_cuda-10.0
export TEST_NAME="$(basename "$1")"
mpiexec nvprof --profile-child-processes --profile-api-trace none --normalized-time-unit us --csv --log-file %q{CI_OUTDIR}/%q{TEST_NAME}-%p.%q{OMPI_COMM_WORLD_RANK}.summary.nvplog julia --color=no --project "$@"
mpiexec nvprof --profile-child-processes --normalized-time-unit us --metrics local_load_transactions,local_store_transactions --csv --log-file %q{CI_OUTDIR}/%q{TEST_NAME}-%p.%q{OMPI_COMM_WORLD_RANK}.metrics.nvplog julia --color=no --project "$@"
