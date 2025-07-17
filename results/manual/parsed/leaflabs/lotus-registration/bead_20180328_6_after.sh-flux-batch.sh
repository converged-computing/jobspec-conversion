#!/bin/bash
#FLUX: --job-name=loopy-fudge-1681
#FLUX: -n=20
#FLUX: --queue=om_all_nodes
#FLUX: -t=172800
#FLUX: --urgency=16

export TZ='America/New_York'

module add mit/matlab/2016b
cd /home/jkinney/lotus-registration
export TZ=America/New_York
matlab -nodisplay -nodesktop -nosplash -r "run('master_reg_bead_20180328_6_after.m');disp('FINISHED');exit;"
