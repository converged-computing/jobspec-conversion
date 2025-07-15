#!/bin/bash
#FLUX: --job-name=salted-dog-6531
#FLUX: -t=10800
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nodesktop -r "gen_skeletons_warped_single_matt"
