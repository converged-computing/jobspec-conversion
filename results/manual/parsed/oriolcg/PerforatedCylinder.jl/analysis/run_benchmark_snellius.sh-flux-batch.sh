#!/bin/bash
#FLUX: --job-name="perf_cylinder"
#FLUX: --queue=thin
#FLUX: -t=172800
#FLUX: --priority=16

export CASE_ID='1'

source ../compile/modules_snellius.sh
export CASE_ID=1
echo "Starting case: $CASE_ID"
mpiexecjl --project=../ -n $1 julia -J ../PerforatedCylinder_parallel.so -O3 --check-bounds=no -e 'include("run_case_benchmark.jl")'
