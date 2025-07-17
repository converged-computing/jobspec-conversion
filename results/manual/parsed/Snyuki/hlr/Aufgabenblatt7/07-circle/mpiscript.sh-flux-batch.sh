#!/bin/bash
#FLUX: --job-name=mpi-circle
#FLUX: --queue=west
#FLUX: --urgency=16

mpirun -np 5 ./circle 13
