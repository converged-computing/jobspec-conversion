#!/bin/bash
#FLUX: --job-name=hello-nalgas-9333
#FLUX: -c=64
#FLUX: --queue=amd
#FLUX: -t=180000
#FLUX: --urgency=16

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=1;r<=100;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_notsqr_plainaxpby/src/axpby_bench 50 10 50 $r 100
done
