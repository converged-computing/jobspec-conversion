#!/bin/bash
#SBATCH --output=west8.out
#SBATCH --error=west8.err
#SBATCH --nodes=8
#SBATCH --ntasks=8
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
