#!/bin/bash
#FLUX: --job-name=delicious-arm-1808
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}'
export OMP_NUM_THREADS='8'

export LD_LIBRARY_PATH=${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}
export OMP_NUM_THREADS=8
python run_sim.py
