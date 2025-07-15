#!/bin/bash
#FLUX: --job-name=doopy-plant-4980
#FLUX: --urgency=16

module load matlab/2018b
matlab -nosplash -nodisplay -nodesktop -r GMMreg_toCommonCoords
