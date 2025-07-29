#!/bin/bash
#FLUX --job-name=salted-motorcycle-7246
#FLUX -t=10800
#FLUX --urgency=16

module load matlab
matlab -nodisplay -nodesktop -r "gen_skeletons_warped_single_matt"
