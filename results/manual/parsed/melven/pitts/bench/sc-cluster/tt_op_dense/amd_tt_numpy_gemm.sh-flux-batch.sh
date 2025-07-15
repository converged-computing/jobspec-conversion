#!/bin/bash
#FLUX: --job-name=grated-carrot-3397
#FLUX: --urgency=16

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=1;r<=100;r++)); do
  n=$((r * 50))
  m=$((r))
  k=$((r * 2))
  echo "n m k: $n $m $k"
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $n $m $k 1000
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $k $m $n 1000
  n=$((r * r))
  m=$((50 * 2))
  k=$((50 * 2))
  echo "n m k: $n $m $k"
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $n $m $k 1000
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $k $m $n 1000
  n=$((50 * r))
  m=$((r * 2))
  k=$((r))
  echo "n m k: $n $m $k"
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $n $m $k 1000
  srun taskset -c 0-127 likwid-pin -c 0-63 python ../../numpy_gemm_bench.py $k $m $n 1000
done
