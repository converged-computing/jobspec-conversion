#!/bin/bash
#FLUX: --job-name=lovely-lemur-4185
#FLUX: --priority=16

module list
pwd
date
matlab -nodisplay -nodesktop -nosplash -r "driverHPMIoptWithADvecQuadnoTR;exit"
