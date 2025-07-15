#!/bin/bash
#FLUX: --job-name=creamy-underoos-1403
#FLUX: --priority=16

module load matlab/R2021a
matlab -nodesktop -nosplash -nodisplay -r main
echo 'finished!'
