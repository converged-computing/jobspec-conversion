#!/bin/bash
#FLUX: --job-name=phat-citrus-7127
#FLUX: -N=2
#FLUX: -n=12
#FLUX: --queue=work
#FLUX: -t=600
#FLUX: --urgency=16

module load python/3.10.10
module load py-mpi4py/3.1.4-py3.10.10
set -ex
srun -n 12 python hello.py
