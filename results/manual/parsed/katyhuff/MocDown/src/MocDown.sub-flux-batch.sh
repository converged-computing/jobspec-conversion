#!/bin/bash
#FLUX: --job-name=MocDown
#FLUX: -n=8
#FLUX: -c=6
#FLUX: --queue=x
#FLUX: -t=864000
#FLUX: --priority=16

. /etc/bashrc ;
which mcnp6.mpi &> /dev/null || module load icc-x86_64/intel-amd64 mvapich2-1.8.1 mcnp6b2 mcnpbindata-6b2 ;
[ -e MocDown.log ] && rm -vf MocDown.log ;
./MocDown.py inp1 -v > MocDown.log ;
