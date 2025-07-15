#!/bin/bash
#FLUX: --job-name=reclusive-cupcake-6708
#FLUX: -N=4
#FLUX: -n=4
#FLUX: --queue=west
#FLUX: -t=7200
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
mpiexec ../writefile 1000000000 1 3
mpiexec ../writefile 1000000000 2 3
