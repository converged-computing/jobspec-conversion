#!/bin/bash
#FLUX: --job-name=salted-frito-1790
#FLUX: --priority=16

export TZ='America/New_York'

module add mit/matlab/2016b
cd /home/jkinney/lotus-registration
export TZ=America/New_York
matlab -nodisplay -nodesktop -nosplash -r "run('master_reg_bead_20180328.m');disp('FINISHED');exit;"
