#!/bin/bash
#SBATCH --output=s_west10.out
#SBATCH --error=s_west10.err
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

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
