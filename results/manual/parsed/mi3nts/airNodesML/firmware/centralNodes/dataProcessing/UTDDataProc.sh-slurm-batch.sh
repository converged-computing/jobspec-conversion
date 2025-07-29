#!/bin/bash
#FLUX: --job-name=utdNodesDataProcessing
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "raw2MatHPC("$SLURM_ARRAY_TASK_ID")"
