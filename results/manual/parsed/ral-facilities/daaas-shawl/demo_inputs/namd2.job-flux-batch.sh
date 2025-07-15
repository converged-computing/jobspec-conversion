#!/bin/bash
#FLUX: --job-name=carnivorous-muffin-3371
#FLUX: --exclusive
#FLUX: --priority=16

module use /apps/eb/modulefiles/all
module load NAMD/2.14-foss-2019b-mpi
mpirun -np 144 namd2 dppc-p1.conf > dppc-p1.out
