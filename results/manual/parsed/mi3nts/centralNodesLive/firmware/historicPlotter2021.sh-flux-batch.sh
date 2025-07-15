#!/bin/bash
#FLUX: --job-name=red-toaster-2422
#FLUX: --urgency=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "liveRun2021DailyPlotter("$SLURM_ARRAY_TASK_ID",'mintsDefinitions.yaml','WSPre','predictrnn')"
