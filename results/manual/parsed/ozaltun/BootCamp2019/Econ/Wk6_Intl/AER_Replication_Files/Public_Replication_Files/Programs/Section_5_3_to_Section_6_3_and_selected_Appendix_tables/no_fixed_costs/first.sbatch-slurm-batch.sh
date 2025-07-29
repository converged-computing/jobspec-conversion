#!/bin/bash
#FLUX: --job-name=first
#FLUX: -c=12
#FLUX: --queue=sandyb
#FLUX: -t=129600
#FLUX: --urgency=16

module load matlab/2013b
mkdir -p /tmp/tintelnot/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID
matlab -nodisplay < Main_search1.m
rm -rf /tmp/tintelnot/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID
