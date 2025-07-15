#!/bin/bash
#FLUX: --job-name=salted-gato-1214
#FLUX: -N=4
#FLUX: -n=12
#FLUX: --queue=west
#FLUX: --priority=16

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi
