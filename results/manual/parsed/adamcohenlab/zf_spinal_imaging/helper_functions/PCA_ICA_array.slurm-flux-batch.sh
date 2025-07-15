#!/bin/bash
#FLUX: --job-name=stinky-kitty-4373
#FLUX: --priority=16

module load matlab/R2018a-fasrc01
matlab -sd "~/" -nosplash -nodesktop -r "ICA_PCA_array($SLURM_ARRAY_TASK_ID)"
