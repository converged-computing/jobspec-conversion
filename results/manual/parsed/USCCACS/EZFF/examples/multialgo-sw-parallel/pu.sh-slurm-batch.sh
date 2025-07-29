#!/bin/bash
#FLUX: --job-name=SW-PARALLEL
#FLUX: -n=32
#FLUX: --queue=priya
#FLUX: -t=14400
#FLUX: --urgency=16

srun -n 32 --mpi=pmi2 /staging/pv/kris658/SOFTWARE/anaconda_2018_12/bin/python3.7 run.py
exit 0
