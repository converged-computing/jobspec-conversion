#!/bin/bash
#FLUX: --job-name=conspicuous-knife-3126
#FLUX: -N=8
#FLUX: -n=8
#FLUX: -t=360
#FLUX: --urgency=16

unset LD_PRELOAD
module load openmpi4/gcc/4.0.5
srun --mpi=pmix_v3 -n 8 ./combined 8 12 1000
