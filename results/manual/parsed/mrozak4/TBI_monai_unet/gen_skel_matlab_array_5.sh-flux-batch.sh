#!/bin/bash
#FLUX: --job-name=hello-lentil-5725
#FLUX: -t=10800
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nodesktop -r "gen_skeletons_warped_single_matt"
