#!/bin/bash
#FLUX: --job-name=evasive-chair-5434
#FLUX: --urgency=16

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=1;r<=100;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_notsqr_plainaxpby/src/axpby_bench 50 10 50 $r 100
done
