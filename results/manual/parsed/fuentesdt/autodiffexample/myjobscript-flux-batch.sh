#!/bin/bash
#FLUX: --job-name=hanky-kitty-0024
#FLUX: --urgency=16

module list
pwd
date
matlab -nodisplay -nodesktop -nosplash -r "driverHPMIoptWithADvecQuadnoTR;exit"
