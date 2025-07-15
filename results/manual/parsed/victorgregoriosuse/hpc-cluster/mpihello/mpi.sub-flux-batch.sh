#!/bin/bash
#FLUX: --job-name=quirky-bike-3647
#FLUX: -t=300
#FLUX: --urgency=16

source /usr/share/spack/setup-env.sh
spack load openmpi
[ -f mpihello ] && rm -f mpihello
mpicc -o mpihello mpihello.c
mpirun -np 10 ./mpihello
exit $?
