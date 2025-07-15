#!/bin/bash
#FLUX: --job-name=peachy-fork-0165
#FLUX: -N=32
#FLUX: -n=32
#FLUX: -c=2
#FLUX: -t=14400
#FLUX: --priority=16

for np in 4 8 12 16 20 24 28 32; do
    for rep in {1..5}; do
        # mpirun -np $np ./../poisson -m 4096
        # mpirun -np $np ./../poisson -m 6144
        # mpirun -np $np ./../poisson -m 8192
        mpirun -np $np ./../poisson -m 10240
    done
done
