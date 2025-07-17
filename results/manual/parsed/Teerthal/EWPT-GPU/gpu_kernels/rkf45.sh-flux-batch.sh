#!/bin/bash
#FLUX: --job-name=bumfuzzled-lemon-9887
#FLUX: --queue=public
#FLUX: -t=1200
#FLUX: --urgency=16

MV2_USE_ALIGNED_ALLOC=1
module load mvapich2-2.3.7-gcc-11.2.0
time mpirun -n 4 julia rk45_main_multiple.jl
module unload mvapich2-2.3.7-gcc-11.2.0
