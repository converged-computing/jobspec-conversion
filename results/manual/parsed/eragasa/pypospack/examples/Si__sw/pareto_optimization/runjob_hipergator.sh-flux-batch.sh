#!/bin/bash
#FLUX: --job-name=Si_sw
#FLUX: -n=64
#FLUX: -t=86400
#FLUX: --urgency=16

pwd; hostname; date
module load intel/2016.0.109
module load impi/5.1.1
echo PYTHONPATH=$PYTHONPATH
PYTHON_BIN=$(which python)
echo PYTHON_BIN=$PYTHON_BIN
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
srun --mpi=pmi2 $PYTHON_BIN mc_iterative_sampler.py
echo "end_time:$(date)"
