#!/bin/bash
#FLUX: --job-name=PecsCheck
#FLUX: -n=8
#FLUX: -c=6
#FLUX: --queue=x
#FLUX: -t=864000
#FLUX: --urgency=16

. /etc/bashrc ;
which mcnp6.mpi &> /dev/null || module load icc-x86_64/intel-amd64 mvapich2-1.8.1 mcnp6b2 mcnpbindata-6b2 ;
[ -e PecsCheck.log ] && rm -vf PecsCheck.log ;
./PecsCheck.py inp1 > PecsCheck.log ;
