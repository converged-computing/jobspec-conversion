#!/bin/bash
#FLUX: --job-name=parallel
#FLUX: -c=16
#FLUX: -t=3900
#FLUX: --priority=16

export PYTHONPATH='/home/dclure/hathi-mpi'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/hathi-mpi
$PYTHONPATH/env/bin/python $PYTHONPATH/jobs/parallel.py 3600
