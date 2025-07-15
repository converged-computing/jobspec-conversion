#!/bin/bash
#FLUX: --job-name=isccp_timing
#FLUX: -t=14400
#FLUX: --priority=16

/home/cphillips/.conda/envs/dev/bin/python make_timing.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
