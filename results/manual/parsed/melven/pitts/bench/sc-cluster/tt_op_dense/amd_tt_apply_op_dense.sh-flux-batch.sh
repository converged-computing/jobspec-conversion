#!/bin/bash
#FLUX: --job-name=butterscotch-sundae-1325
#FLUX: --priority=16

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=1;r<=100;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd/src/apply_op_dense_bench 50 $r 2 1000
done
