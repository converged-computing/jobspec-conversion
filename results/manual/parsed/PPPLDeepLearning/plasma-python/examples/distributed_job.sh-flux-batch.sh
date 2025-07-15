#!/bin/bash
#FLUX: --job-name=creamy-lettuce-9443
#FLUX: --priority=16

module load anaconda
module load cudatoolkit/7.5 cudann
module load openmpi
echo "Removing old model checkpoints."
rm /tigress/jk7/data/model_checkpoints/*
echo "Running distributed learning"
mpirun -npernode 4 python mpi_learn.py
