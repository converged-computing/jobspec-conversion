#!/bin/bash
#FLUX: --job-name=spicy-underoos-8025
#FLUX: -N=2
#FLUX: -n=12
#FLUX: --priority=16

module load python/3.10.10
module load py-mpi4py/3.1.4-py3.10.10
set -ex
srun -n 12 python hello.py
