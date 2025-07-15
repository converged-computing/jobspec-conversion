#!/bin/bash
#FLUX: --job-name=all2all
#FLUX: -N=2
#FLUX: -t=60
#FLUX: --priority=16

module load openmpi
module load python/3.7.2
source venv/bin/activate
mpirun -bind-to none ./sendrecv.py 
