#!/bin/bash
#FLUX: --job-name=chunky-dog-0145
#FLUX: -N=3
#FLUX: -n=24
#FLUX: --queue=west
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi2
