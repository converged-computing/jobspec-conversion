#!/bin/bash
#FLUX: --job-name=conspicuous-banana-9239
#FLUX: -N=10
#FLUX: -n=10
#FLUX: --queue=west
#FLUX: -t=7200
#FLUX: --priority=16

export DARSHAN_DISABLE_SHARED_REDUCTION='1'

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
export DARSHAN_DISABLE_SHARED_REDUCTION=1
mpiexec -env LD_PRELOAD /home/plehn/darshan-build/lib/libdarshan.so ../writefile 1000000000 1 3
mpiexec -env LD_PRELOAD /home/plehn/darshan-build/lib/libdarshan.so ../writefile 1000000000 2 3
