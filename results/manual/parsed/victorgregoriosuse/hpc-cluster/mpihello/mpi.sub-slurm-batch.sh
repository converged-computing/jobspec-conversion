#!/bin/bash
#SBATCH --job-name=testing
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=normal

source /usr/share/spack/setup-env.sh
spack load openmpi
[ -f mpihello ] && rm -f mpihello
mpicc -o mpihello mpihello.c
mpirun -np 10 ./mpihello
exit $?
