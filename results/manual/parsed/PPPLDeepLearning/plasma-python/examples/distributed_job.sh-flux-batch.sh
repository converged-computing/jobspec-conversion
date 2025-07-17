#!/bin/bash
#FLUX: --job-name=anxious-signal-3960
#FLUX: -N=10
#FLUX: -t=120
#FLUX: --urgency=16

module load anaconda
module load cudatoolkit/7.5 cudann
module load openmpi
echo "Removing old model checkpoints."
rm /tigress/jk7/data/model_checkpoints/*
echo "Running distributed learning"
mpirun -npernode 4 python mpi_learn.py
