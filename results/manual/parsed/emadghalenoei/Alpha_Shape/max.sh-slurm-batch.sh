#!/bin/bash
#FLUX: --job-name=gassy-dog-4764
#FLUX: --queue=geo
#FLUX: -t=86400
#FLUX: --urgency=16

module load mpich/3.2.1-gnu
mpirun -np 20 python3 MaxFinder.py
