#!/bin/bash
#SBATCH --output=d_west10.out
#SBATCH --error=d_west10.err
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=west

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
