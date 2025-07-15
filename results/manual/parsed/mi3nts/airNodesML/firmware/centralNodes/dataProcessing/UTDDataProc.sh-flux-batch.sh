#!/bin/bash
#FLUX: --job-name=strawberry-gato-3139
#FLUX: --priority=16

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "raw2MatHPC("$SLURM_ARRAY_TASK_ID")"
