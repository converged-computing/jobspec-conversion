#!/bin/bash
#FLUX: --job-name=fat-gato-6550
#FLUX: -N=4
#FLUX: -c=4
#FLUX: -t=59
#FLUX: --urgency=16

export LD_PRELOAD='/spack/apps/gcc/8.3.0/lib64/libstdc++.so.6'

module load gcc/8.3.0 
export LD_PRELOAD=/spack/apps/gcc/8.3.0/lib64/libstdc++.so.6
mpirun -bind-to none -n 4 ./cart
