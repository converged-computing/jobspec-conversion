#!/bin/bash
#FLUX: --job-name=chocolate-parrot-2825
#FLUX: -t=900
#FLUX: --priority=16

module load mpich/ge/gcc/64/3.2
module load cuda10.0/toolkit/10.0.130
which mpirun
which mpiexec
mpirun -n 3 ./vector.out "$@"
