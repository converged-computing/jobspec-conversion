#!/bin/bash
#FLUX: --job-name=stinky-chip-6380
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --queue=west
#FLUX: -t=60
#FLUX: --urgency=16

. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
mpiexec ./partdiff-par 1 2 0 2 2 1
