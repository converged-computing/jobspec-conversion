#!/bin/bash
#FLUX: --job-name=psycho-eagle-0739
#FLUX: --priority=16

module load matlab/R2021a
matlab -nodesktop -nosplash -nodisplay -r main1
