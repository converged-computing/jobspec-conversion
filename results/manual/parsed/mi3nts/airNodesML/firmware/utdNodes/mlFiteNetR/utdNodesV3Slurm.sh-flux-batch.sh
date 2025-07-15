#!/bin/bash
#FLUX: --job-name=purple-destiny-5956
#FLUX: --urgency=16

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesV3("$SLURM_ARRAY_TASK_ID")"
