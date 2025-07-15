#!/bin/bash
#FLUX: --job-name=frigid-blackbean-6759
#FLUX: --urgency=16

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesCal_RS_ONN_01("$SLURM_ARRAY_TASK_ID")"
