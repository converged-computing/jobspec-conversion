#!/bin/bash
#FLUX: --job-name=outstanding-knife-8793
#FLUX: -N=10
#FLUX: --priority=16

export NOISE_PATH='/net/archive/groups/plgghmsneuro/noise.npy'

export NOISE_PATH=/net/archive/groups/plgghmsneuro/noise.npy
module load plgrid/libs/python-mpi4py/3.0.1-python-3.6
mpirun -np 240 python3 -m implementation.experiments.hms_atari_sea -e 60
