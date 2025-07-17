#!/bin/bash
#FLUX: --job-name=hms-neuro-job
#FLUX: -N=10
#FLUX: --queue=plgrid-short
#FLUX: -t=3600
#FLUX: --urgency=16

export NOISE_PATH='/net/archive/groups/plgghmsneuro/noise.npy'

export NOISE_PATH=/net/archive/groups/plgghmsneuro/noise.npy
module load plgrid/libs/python-mpi4py/3.0.1-python-3.6
mpirun -np 240 python3 -m implementation.experiments.hms_atari_sea -e 60
