#!/bin/bash
#FLUX: --job-name=utdNodesTest0
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesCal_Test0("$SLURM_ARRAY_TASK_ID")"
