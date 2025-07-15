#!/bin/bash
#FLUX: --job-name=scatter
#FLUX: -N=16
#FLUX: -t=10800
#FLUX: --priority=16

export PYTHONPATH='/home/dclure/hathi-mpi'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/hathi-mpi
mpirun -x PYTHONPATH $PYTHONPATH/env/bin/python \
    $PYTHONPATH/jobs/scatter_list.py
