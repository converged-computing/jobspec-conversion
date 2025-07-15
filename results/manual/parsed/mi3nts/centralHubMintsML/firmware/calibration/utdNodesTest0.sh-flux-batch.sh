#!/bin/bash
#FLUX: --job-name=lovable-fudge-5271
#FLUX: --priority=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesCal_Test0("$SLURM_ARRAY_TASK_ID")"
