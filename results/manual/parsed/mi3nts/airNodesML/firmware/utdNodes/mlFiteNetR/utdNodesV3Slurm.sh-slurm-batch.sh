#!/bin/bash
#FLUX: --job-name=utdNodesCalV2
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesV3("$SLURM_ARRAY_TASK_ID")"
