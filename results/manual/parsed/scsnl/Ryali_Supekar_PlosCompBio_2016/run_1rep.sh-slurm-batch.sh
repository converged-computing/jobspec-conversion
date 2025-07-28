#!/bin/bash
#FLUX: --job-name=rep1
#FLUX: -n=16
#FLUX: -t=2100
#FLUX: --urgency=16

module load matlab/R2014a
module load spm/12b
matlab -nojit -nosplash -nodesktop -nodisplay -r "main_vbhmm_HCP_replication("$1");exit;"
