#!/bin/bash
#FLUX: --job-name=lqy
#FLUX: --queue=compute
#FLUX: --urgency=16

module load matlab/R2021a
matlab -nodesktop -nosplash -nodisplay -r main1
