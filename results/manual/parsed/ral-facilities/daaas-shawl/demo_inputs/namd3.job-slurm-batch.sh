#!/bin/bash
#FLUX: --job-name=dppc-p1
#FLUX: -n=144
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

module use /apps/eb/modulefiles/all
module load NAMD/2.14-foss-2019b-mpi
mpirun -np 144 namd2 dppc-p1.conf > dppc-p1.out
