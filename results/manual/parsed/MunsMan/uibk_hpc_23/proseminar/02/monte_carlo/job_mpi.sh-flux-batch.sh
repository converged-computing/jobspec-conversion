#!/bin/bash
#FLUX: --job-name=pi-mpi
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --urgency=16

module load openmpi/3.1.6-gcc-12.2.0-d2gmn55 
mpiexec ~/a.out 1000000000
