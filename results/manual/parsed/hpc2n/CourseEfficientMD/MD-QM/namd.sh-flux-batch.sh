#!/bin/bash
#FLUX: --job-name=blank-lizard-8586
#FLUX: --urgency=16

ml GCC/7.3.0-2.30  OpenMPI/3.1.1
ml NAMD/2.13-mpi
mpirun -np 28 namd2 4ake_eq.conf > logfile.txt
