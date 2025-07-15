#!/bin/bash
#FLUX: --job-name=abcd
#FLUX: --urgency=16

module purge
module load MATLAB/R2018b
test
matlab -nodesktop -nosplash -r "sub_n=$1;Step_one_site16_code_par.m;quit"
