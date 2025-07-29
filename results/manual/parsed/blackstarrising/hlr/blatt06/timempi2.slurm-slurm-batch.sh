#!/bin/bash
#SBATCH --output=timempi2.out
#SBATCH --nodes=3
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --partition=west

. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
mpiexec ./timempi2
