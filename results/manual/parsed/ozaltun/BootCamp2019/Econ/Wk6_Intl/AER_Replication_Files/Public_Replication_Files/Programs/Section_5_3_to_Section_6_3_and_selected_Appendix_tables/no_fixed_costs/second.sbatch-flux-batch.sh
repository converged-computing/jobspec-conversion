#!/bin/bash
#FLUX: --job-name=second
#FLUX: -c=12
#FLUX: --queue=sandyb
#FLUX: -t=129600
#FLUX: --priority=16

module load matlab/2013b
mkdir -p /tmp/tintelnot/$SLURM_JOB_ID
matlab -nodisplay < Main_stat_counter2.m
rm -rf /tmp/tintelnot/$SLURM_JOB_ID
