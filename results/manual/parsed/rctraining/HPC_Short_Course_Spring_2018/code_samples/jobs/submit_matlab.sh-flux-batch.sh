#!/bin/bash
#FLUX: --job-name=sticky-soup-5679
#FLUX: --queue=shas
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load matlab
cd progs
matlab -nodisplay -nodesktop -r "clear; matlab_tic;"
