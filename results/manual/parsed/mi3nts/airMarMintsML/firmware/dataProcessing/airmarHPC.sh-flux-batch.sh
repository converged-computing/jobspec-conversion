#!/bin/bash
#FLUX: --job-name=evasive-butter-4354
#FLUX: --urgency=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "try airmar0001; catch; end; quit"
