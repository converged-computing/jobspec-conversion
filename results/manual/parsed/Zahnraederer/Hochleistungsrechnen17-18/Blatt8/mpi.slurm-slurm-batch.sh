#!/bin/bash
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=3
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
if [ "${SLURM_PARTITION}" = 'abu' ]
then
	export MPICH_NEMESIS_NETMOD=ib
fi
mpiexec ./partdiff-par 1 2 0 2 2 1
