#!/bin/bash
#FLUX: --job-name=al_svm
#FLUX: -n=3
#FLUX: --queue=normal
#FLUX: -t=16200
#FLUX: --urgency=16

module load python3
module list
pwd
date
ibrun python3 run_mpi.py         # Use ibrun instead of mpirun or mpiexec
