#!/bin/bash
#FLUX: --job-name=grated-hope-6326
#FLUX: -c=10
#FLUX: -t=28800
#FLUX: --urgency=16

module load pytorch
python main_sarsa.py --array_name=Jun6_10M --array_id=$SLURM_ARRAY_TASK_ID 
