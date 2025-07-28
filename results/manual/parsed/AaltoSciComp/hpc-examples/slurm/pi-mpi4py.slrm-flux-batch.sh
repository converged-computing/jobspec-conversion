#!/bin/bash
#FLUX: --job-name=adorable-parrot-2964
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load anaconda
mpirun python pi-mpi.py
