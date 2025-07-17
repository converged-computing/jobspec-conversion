#!/bin/bash
#FLUX: --job-name=LFPy Circuit
#FLUX: -N=10
#FLUX: -t=1500
#FLUX: --urgency=16

module load NiaEnv/2018a
module load intel/2018.2
module load intelmpi/2018.2
module load anaconda3/2018.12
conda activate lfpy
unset DISPLAY
mpiexec -n 400 python circuit.py 1234
