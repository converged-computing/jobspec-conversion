#!/bin/bash
#FLUX: --job-name=cowy-poo-5081
#FLUX: -N=3
#FLUX: -n=24
#FLUX: --queue=west
#FLUX: --priority=16

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi2
