#!/bin/bash
#FLUX: --job-name=evasive-staircase-7826
#FLUX: --urgency=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "liveRun2021Daily("$SLURM_ARRAY_TASK_ID",'mintsDefinitions.yaml','WSPre','predictrnn')"
