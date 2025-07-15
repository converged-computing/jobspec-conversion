#!/bin/bash
#FLUX: --job-name=isccp_solar
#FLUX: -t=14400
#FLUX: --urgency=16

/home/cphillips/.conda/envs/dev/bin/python solar.py --missing $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
