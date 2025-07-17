#!/bin/bash
#FLUX: --job-name=combine2a
#FLUX: --queue=broadwl
#FLUX: -t=1200
#FLUX: --urgency=16

module load matlab/2019b
matlab -nodisplay < /home/livingstonb/GitHub/Continuous_Time_HA/code/batch/combine_runs.m
