#!/bin/bash
#FLUX: --job-name=anxious-pedo-1874
#FLUX: -n=4
#FLUX: -t=300
#FLUX: --urgency=16

export MATLABPATH='${MATLABPATH}:../../matlab'

module load matlab/R2014a
export MATLABPATH=${MATLABPATH}:../../matlab
mpirun -n 4 matlab -r "seek,exit"
