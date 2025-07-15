#!/bin/bash
#FLUX: --job-name=moolicious-arm-9633
#FLUX: -t=300
#FLUX: --priority=16

source /usr/share/spack/setup-env.sh
spack load openmpi
[ -f mpihello ] && rm -f mpihello
mpicc -o mpihello mpihello.c
mpirun -np 10 ./mpihello
exit $?
