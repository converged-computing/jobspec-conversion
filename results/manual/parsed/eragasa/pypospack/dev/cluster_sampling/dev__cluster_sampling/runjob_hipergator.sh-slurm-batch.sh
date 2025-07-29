#!/bin/bash
#FLUX: --job-name=Ni_fs
#FLUX: -n=16
#FLUX: -t=43200
#FLUX: --urgency=16

pwd; hostname; date
module load intel/2018.1.163
module load openmpi/3.0.0
echo PYTHONPATH=$PYTHONPATH
PYTHON_BIN=$(which python)
echo PYTHON_BIN=$PYTHON_BIN
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
srun --mpi=pmix_v1 $PYTHON_BIN mc_iterative_sampler.py
echo "end_time:$(date)"
