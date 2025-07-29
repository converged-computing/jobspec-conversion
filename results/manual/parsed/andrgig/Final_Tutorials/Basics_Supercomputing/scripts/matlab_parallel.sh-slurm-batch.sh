#!/bin/bash
#FLUX: --job-name=Matlab_parallel
#FLUX: -t=180
#FLUX: --urgency=16

ml matlab
matlab -nodisplay -nodesktop -r "clear; num_workers=12; matlab_parallel;"
