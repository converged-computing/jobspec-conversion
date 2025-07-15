#!/bin/bash
#FLUX: --job-name=boopy-mango-2206
#FLUX: --priority=16

export MATLABPATH='${MATLABPATH}:../../matlab'

module load matlab/R2014a
export MATLABPATH=${MATLABPATH}:../../matlab
mpirun -n 4 matlab -r "seek,exit"
