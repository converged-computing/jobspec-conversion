#!/bin/bash
#FLUX: --job-name=astute-peas-2958
#FLUX: --priority=16

export MATLABPATH='../../matlab'

module load matlab/R2014a
export MATLABPATH=../../matlab
mpirun -n 2 matlab -r "itest,exit"
