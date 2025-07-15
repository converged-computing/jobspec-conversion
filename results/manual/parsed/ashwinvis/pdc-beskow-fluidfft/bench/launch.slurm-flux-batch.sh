#!/bin/bash
#FLUX: --job-name=joyous-earthworm-7011
#FLUX: -n=32
#FLUX: -t=3658
#FLUX: --priority=16

export FLUID_PROC_MESH='2x32'

N0=512
N1=512
N2=128
source /etc/profile
module load gcc/7.2.0
module swap PrgEnv-cray PrgEnv-intel
module swap intel intel/18.0.0.128
module add cdt/17.10 # add cdt module
export FLUID_PROC_MESH='2x32'
aprun -n $(nproc) \
       test_bench.out --N0=$N0 --N1=$N1 --N2=$N2
