#!/bin/bash
#FLUX: --job-name=scruptious-parrot-0828
#FLUX: --priority=16

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "liveRun2021DailyPlotter("$SLURM_ARRAY_TASK_ID",'mintsDefinitions.yaml','WSPre','predictrnn')"
