#!/bin/bash
#FLUX --job-name=outstanding-hobbit-9655
#FLUX --queue=serial_requeue
#FLUX -t=36000
#FLUX --urgency=16

module load math/matlab-R2014b
matlab -nojvm -nodisplay -nodesktop -r \
	"job=$SLURM_ARRAY_TASK_ID;addpath(genpath('.'));testTwitter;quit"
