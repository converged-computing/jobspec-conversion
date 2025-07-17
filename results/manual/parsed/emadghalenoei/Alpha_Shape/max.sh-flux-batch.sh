#!/bin/bash
#FLUX: --job-name=bumfuzzled-buttface-9602
#FLUX: --queue=geo
#FLUX: -t=86400
#FLUX: --urgency=16

module load mpich/3.2.1-gnu
mpirun -np 20 python3 MaxFinder.py
