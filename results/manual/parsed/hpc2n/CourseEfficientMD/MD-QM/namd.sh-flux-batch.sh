#!/bin/bash
#FLUX: --job-name=crusty-nunchucks-6193
#FLUX: -n=28
#FLUX: -t=3000
#FLUX: --urgency=16

ml GCC/7.3.0-2.30  OpenMPI/3.1.1
ml NAMD/2.13-mpi
mpirun -np 28 namd2 4ake_eq.conf > logfile.txt
