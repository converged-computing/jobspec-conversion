#!/bin/bash
#FLUX: --job-name=red-milkshake-9456
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3 
ml NAMD/2.14-mpi
mpirun -np 28 namd2 4ake_eq.conf > logfile.txt
