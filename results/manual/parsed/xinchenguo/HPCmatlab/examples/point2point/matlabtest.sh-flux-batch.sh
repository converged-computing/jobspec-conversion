#!/bin/bash
#FLUX: --job-name=pusheena-blackbean-8198
#FLUX: --urgency=16

export MATLABPATH='../../matlab'

module load matlab/R2014a
export MATLABPATH=../../matlab
mpirun -n 2 matlab -r "itest,exit"
