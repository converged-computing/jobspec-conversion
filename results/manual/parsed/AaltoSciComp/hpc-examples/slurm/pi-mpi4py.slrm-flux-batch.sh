#!/bin/bash
#FLUX: --job-name=eccentric-chip-0518
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load anaconda
mpirun python pi-mpi.py
