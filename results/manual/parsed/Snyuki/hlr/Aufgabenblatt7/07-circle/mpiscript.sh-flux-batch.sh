#!/bin/bash
#FLUX: --job-name=mpi-circle
#FLUX: --urgency=16

mpirun -np 5 ./circle 13
