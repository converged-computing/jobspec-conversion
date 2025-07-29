#!/bin/bash
#SBATCH --output=timempi.out
#SBATCH --nodes=4
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi
