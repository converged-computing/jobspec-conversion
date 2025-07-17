#!/bin/bash
#FLUX: --job-name=dirty-taco-1859
#FLUX: -N=4
#FLUX: -n=12
#FLUX: --queue=west
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi
