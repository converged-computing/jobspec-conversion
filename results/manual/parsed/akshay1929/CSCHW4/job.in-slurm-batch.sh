#!/bin/bash
#FLUX: --job-name=job-@BENCHMARK@
#FLUX: -t=240
#FLUX: --urgency=16

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export PERF_COUNTER_GROUP='HBM_CACHE'
export MARKER_FLAG='-m'

export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export PERF_COUNTER_GROUP=HBM_CACHE
export MARKER_FLAG="-m"
for N in 128 512 2048 # loop over problem sizes
   do
      for t in 1 4 16 64  # loop over concurrency level
         do
         let maxcore=$t-1
         echo srun -n 1 likwid-perfctr $MARKER_FLAG -g $PERF_COUNTER_GROUP -C N:0-$maxcore ./benchmark-@BENCHMARK@ -N $N 
         srun -n 1 likwid-perfctr $MARKER_FLAG -g $PERF_COUNTER_GROUP -C N:0-$maxcore ./benchmark-@BENCHMARK@ -N $N 
         done # iterate over concurrency level
done # iterate over problem size
