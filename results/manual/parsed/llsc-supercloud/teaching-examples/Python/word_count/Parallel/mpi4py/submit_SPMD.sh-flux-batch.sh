#!/bin/bash
#FLUX --job-name=goodbye-carrot-5947
#FLUX -n=4
#FLUX --urgency=16

module load anaconda/2023a
module load mpi/openmpi-4.1.3
mpirun python top5norm_SPMD.py
