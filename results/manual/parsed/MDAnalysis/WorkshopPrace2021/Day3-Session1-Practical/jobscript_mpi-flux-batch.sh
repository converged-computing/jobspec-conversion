#!/bin/bash
#FLUX: --job-name=hello-milkshake-0489
#FLUX: --priority=16

source /project/jhlsrf005/JHL_hooks/env
mpirun -np 4 ./mpi_example.py
