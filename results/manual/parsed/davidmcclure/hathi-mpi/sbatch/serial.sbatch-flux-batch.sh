#!/bin/bash
#FLUX: --job-name=serial
#FLUX: -t=3900
#FLUX: --urgency=16

export PYTHONPATH='/home/dclure/hathi-mpi'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/hathi-mpi
$PYTHONPATH/env/bin/python $PYTHONPATH/jobs/serial.py 3600
