#!/bin/bash
#FLUX: --job-name=phat-nalgas-1997
#FLUX: -N=10
#FLUX: -n=10
#FLUX: --queue=west
#FLUX: -t=7200
#FLUX: --urgency=16

export SCOREP_ENABLE_TRACING='TRUE'

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi scorep
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
export SCOREP_ENABLE_TRACING=TRUE
mpiexec ../writefile-scorep 1000000000 1 3
mpiexec ../writefile-scorep 1000000000 2 3
