#!/bin/bash
#FLUX: --job-name=bricky-poodle-6133
#FLUX: --urgency=16

MV2_USE_ALIGNED_ALLOC=1
module load mvapich2-2.3.7-gcc-11.2.0
time mpirun -n 4 julia rk45_main_multiple.jl
module unload mvapich2-2.3.7-gcc-11.2.0
