#!/bin/bash
#FLUX: --job-name=mpi_test
#FLUX: --queue=shared
#FLUX: -t=1800
#FLUX: --urgency=16

time mpirun -n 4 nrniv -python -mpi init.py
