#!/bin/bash
#SBATCH --output=output/output.out
#SBATCH --nodes=4
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --partition=west

rm output/*
. /etc/profile.d/modules.sh
. /etc/profile.d/wr-spack.sh
spack load --dependencies mpi
spack load -r scorep
SCOREP_ENABLE_TRACING=true
mpiexec ./partdiff 1 1 512 1 2 20
