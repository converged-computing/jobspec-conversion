#!/bin/bash
#FLUX: --job-name=ctime
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --priority=16

module load matlab/2019b
matlab -nodisplay < /home/livingstonb/GitHub/Continuous_Time_HA/master.m
