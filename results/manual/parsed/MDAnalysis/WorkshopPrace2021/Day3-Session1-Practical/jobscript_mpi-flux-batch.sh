#!/bin/bash
#FLUX: --job-name=phat-motorcycle-0256
#FLUX: --urgency=16

source /project/jhlsrf005/JHL_hooks/env
mpirun -np 4 ./mpi_example.py
