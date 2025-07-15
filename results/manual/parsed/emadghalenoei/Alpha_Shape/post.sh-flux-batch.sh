#!/bin/bash
#FLUX: --job-name=fat-citrus-4596
#FLUX: --queue=geo
#FLUX: -t=432000
#FLUX: --urgency=16

module load mpich/3.2.1-gnu
mpirun -np 20 python3 Posterior_Process.py
