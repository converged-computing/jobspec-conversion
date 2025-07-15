#!/bin/bash
#FLUX: --job-name=reclusive-buttface-6405
#FLUX: --exclusive
#FLUX: --urgency=16

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 smd.inp > output_smd.dat
