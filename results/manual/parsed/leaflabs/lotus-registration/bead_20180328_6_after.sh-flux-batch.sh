#!/bin/bash
#FLUX: --job-name=bumfuzzled-onion-9649
#FLUX: --urgency=16

export TZ='America/New_York'

module add mit/matlab/2016b
cd /home/jkinney/lotus-registration
export TZ=America/New_York
matlab -nodisplay -nodesktop -nosplash -r "run('master_reg_bead_20180328_6_after.m');disp('FINISHED');exit;"
