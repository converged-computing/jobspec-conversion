#!/bin/bash
#SBATCH --job-name=MocDown
#SBATCH --account=neutronics
#SBATCH --output=MocDown.o%j
#SBATCH --error=MocDown.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=6
#SBATCH --time=10-00:00:00
#SBATCH --partition=x

. /etc/bashrc ;
which mcnp6.mpi &> /dev/null || module load icc-x86_64/intel-amd64 mvapich2-1.8.1 mcnp6b2 mcnpbindata-6b2 ;
[ -e MocDown.log ] && rm -vf MocDown.log ;
./MocDown.py inp1 -v > MocDown.log ;
