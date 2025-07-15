#!/bin/bash
#FLUX: --job-name=hairy-banana-9788
#FLUX: -t=28800
#FLUX: --priority=16

module load pytorch
python main_sarsa.py --array_name=Jun6_10M --array_id=$SLURM_ARRAY_TASK_ID 
