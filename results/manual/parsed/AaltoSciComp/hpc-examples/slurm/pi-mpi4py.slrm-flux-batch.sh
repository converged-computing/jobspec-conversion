#!/bin/bash
#FLUX: --job-name=gloopy-muffin-5018
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load anaconda
mpirun python pi-mpi.py
