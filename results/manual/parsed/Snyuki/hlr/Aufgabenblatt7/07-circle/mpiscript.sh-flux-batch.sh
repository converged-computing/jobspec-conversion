#!/bin/bash
#FLUX: --job-name=mpi-circle
#FLUX: --priority=16

mpirun -np 5 ./circle 13
