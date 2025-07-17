#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: --queue=skx-normal
#FLUX: -t=172800
#FLUX: --urgency=16

module list
pwd
date
matlab -nodisplay -nodesktop -nosplash -r "driverHPMIoptWithADvecQuadnoTR;exit"
