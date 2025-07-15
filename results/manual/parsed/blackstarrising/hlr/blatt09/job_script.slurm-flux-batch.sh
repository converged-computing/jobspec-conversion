#!/bin/bash
#FLUX: --job-name=dirty-animal-1953
#FLUX: -N=4
#FLUX: -n=5
#FLUX: --queue=west
#FLUX: --priority=16

rm output/*
. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
spack load -r scorep
SCOREP_ENABLE_TRACING=true
mpiexec ./partdiff 1 1 512 1 2 20
