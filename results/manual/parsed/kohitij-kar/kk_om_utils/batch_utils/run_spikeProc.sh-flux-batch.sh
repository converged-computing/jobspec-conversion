#!/bin/bash
#FLUX: --job-name=spk_proc
#FLUX: -t=36000
#FLUX: --priority=16

matlab -nodesktop -nosplash -r "cd('/home/kohitij/kk_om_utils'); addpath(genpath(pwd)); date = '170522'; runGetTrialTimes('num','$SLURM_ARRAY_TASK_ID','date',date); runSpikeDetection('date',date,'num','$SLURM_ARRAY_TASK_ID'); runGetPSTH('num','$SLURM_ARRAY_TASK_ID','date',date); exit"
