#!/bin/bash
#FLUX: --job-name=chocolate-car-4750
#FLUX: -t=10800
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nodesktop -r "gen_skeletons_warped_single_matt"
