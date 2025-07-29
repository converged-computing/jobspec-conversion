#!/bin/bash
#FLUX: --job-name=GMMreg_7
#FLUX: -c=12
#FLUX: -t=39600
#FLUX: --urgency=16

module load matlab/2018b
matlab -nosplash -nodisplay -nodesktop -r GMMreg_toCommonCoords
