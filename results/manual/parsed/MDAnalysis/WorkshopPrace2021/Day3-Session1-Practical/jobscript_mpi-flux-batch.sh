#!/bin/bash
#FLUX: --job-name=MPI_job
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

source /project/jhlsrf005/JHL_hooks/env
mpirun -np 4 ./mpi_example.py
