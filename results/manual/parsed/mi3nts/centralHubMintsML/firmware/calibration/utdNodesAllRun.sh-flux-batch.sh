#!/bin/bash
#FLUX: --job-name=utdNodesAll
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "try utdNodesOptSolo3("$SLURM_ARRAY_TASK_ID"); catch; end; quit"
