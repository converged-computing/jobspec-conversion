#!/bin/bash
#FLUX: --job-name=creamy-rabbit-2555
#FLUX: --queue=geo
#FLUX: -t=432000
#FLUX: --urgency=16

module load mpich/3.2.1-gnu
mpirun -np 20 python3 Posterior_Process.py
