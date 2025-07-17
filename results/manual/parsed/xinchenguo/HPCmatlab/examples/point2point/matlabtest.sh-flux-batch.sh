#!/bin/bash
#FLUX: --job-name=creamy-cherry-6213
#FLUX: -n=2
#FLUX: -t=300
#FLUX: --urgency=16

export MATLABPATH='../../matlab'

module load matlab/R2014a
export MATLABPATH=../../matlab
mpirun -n 2 matlab -r "itest,exit"
