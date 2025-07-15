#!/bin/bash
#FLUX: --job-name=crunchy-train-8359
#FLUX: --urgency=16

module load math/matlab-R2014b
matlab -nojvm -nodisplay -nodesktop -r \
	"job=$SLURM_ARRAY_TASK_ID;addpath(genpath('.'));testTwitter;quit"
