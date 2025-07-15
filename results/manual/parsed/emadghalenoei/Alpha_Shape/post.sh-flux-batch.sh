#!/bin/bash
#FLUX: --job-name=blue-salad-5723
#FLUX: --queue=geo
#FLUX: -t=432000
#FLUX: --priority=16

module load mpich/3.2.1-gnu
mpirun -np 20 python3 Posterior_Process.py
