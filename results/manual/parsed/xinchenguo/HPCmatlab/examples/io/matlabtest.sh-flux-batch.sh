#!/bin/bash
#FLUX: --job-name=placid-destiny-6885
#FLUX: -n=4
#FLUX: -t=300
#FLUX: --urgency=16

export MATLABPATH='${MATLABPATH}:../../matlab'

module load matlab/R2014a
export MATLABPATH=${MATLABPATH}:../../matlab
mpirun -n 4 matlab -r "seek,exit"
