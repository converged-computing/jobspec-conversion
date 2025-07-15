#!/bin/bash
#FLUX: --job-name=job-@BENCHMARK@
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export PERF_COUNTER_GROUP='FLOPS_DP'
export MARKER_FLAG='-m'

unset OMP_NUM_THREADS
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export PERF_COUNTER_GROUP=FLOPS_DP
export MARKER_FLAG="-m"
for N in 128 512 2048 # loop over problem sizes
   do
      for t in 1 4 16 64  # loop over concurrency level
         do
         let maxcore=$t-1
         echo ./benchmark-@BENCHMARK@ -N $N 
         ./benchmark-@BENCHMARK@ -N $N 
         done # iterate over concurrency level
done # iterate over problem size
