#!/bin/bash
#FLUX: --job-name=joyous-diablo-6641
#FLUX: --priority=16

module load matlab/2018b
matlab -nosplash -nodisplay -nodesktop -r GMMreg_toCommonCoords
