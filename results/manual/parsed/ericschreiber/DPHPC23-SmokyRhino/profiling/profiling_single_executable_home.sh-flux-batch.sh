#!/bin/bash
#FLUX: --job-name=profiling
#FLUX: -t=600
#FLUX: --priority=16

command="$1"
module load cuda/12.1.1 cmake/3.21.3 gcc/10.2.0
nvprof --analysis-metrics \
        --cpu-thread-tracing on \
        --print-api-trace \
        --metrics all \
        --profile-child-processes \
        --system-profiling on \
        --trace api,gpu \
        --track-memory-allocations on \
        --events all \
        --csv \
        --export-profile /users/eschreib/niklas/DPHPC23-SmokyRhino/profiling/results/output%p.nvprof \
        $command > /users/eschreib/niklas/DPHPC23-SmokyRhino/profiling/results/profiling.out 2>&1
