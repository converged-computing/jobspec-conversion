#!/bin/bash
#FLUX: --job-name=profiling
#FLUX: -t=600
#FLUX: --priority=16

script="$1"
config="$2"
output_path="$3"
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
        --export-profile /scratch/eschreib/personal_spaces/niklas/DPHPC23-SmokyRhino/profiling/results/output%p.nvprof \
        $script $config $output_path > /scratch/eschreib/personal_spaces/niklas/DPHPC23-SmokyRhino/profiling/results/profiling.out 2>&1
