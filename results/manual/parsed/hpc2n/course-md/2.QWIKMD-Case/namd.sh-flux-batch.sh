#!/bin/bash
#FLUX: --job-name=nerdy-train-4741
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3
ml NAMD/2.14-mpi 
srun namd2 Minimization.conf  > output_minimization.dat
srun namd2 Annealing.conf     > output_annealing.dat
srun namd2 Equilibration.conf > output_equilibration.dat 
