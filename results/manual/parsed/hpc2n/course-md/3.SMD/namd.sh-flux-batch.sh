#!/bin/bash
#FLUX: --job-name=fugly-pancake-1171
#FLUX: -n=28
#FLUX: --exclusive
#FLUX: -t=1200
#FLUX: --urgency=16

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 smd.inp > output_smd.dat
