#!/bin/bash
#FLUX: --job-name=cowy-taco-0374
#FLUX: --priority=16

module load math/matlab-R2014b
matlab -nojvm -nodisplay -nodesktop -r \
	"job=$SLURM_ARRAY_TASK_ID;addpath(genpath('.'));testTwitter;quit"
