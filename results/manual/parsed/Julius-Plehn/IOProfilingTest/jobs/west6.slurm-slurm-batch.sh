#!/bin/bash
#SBATCH --output=west6.out
#SBATCH --error=west6.err
#SBATCH --nodes=6
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
mpiexec ../writefile 1000000000 1 3
mpiexec ../writefile 1000000000 2 3
