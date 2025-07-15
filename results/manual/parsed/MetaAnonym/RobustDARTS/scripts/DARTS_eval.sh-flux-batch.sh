#!/bin/bash
#FLUX: --job-name=cowy-fork-6549
#FLUX: --urgency=16

source activate pytorch-0.3.1-cu8-py36
python src/evaluation/train.py --cutout --auxiliary --job_id $SLURM_ARRAY_JOB_ID --task_id 1 --seed 1 --space $1 --dataset $2 --search_dp $3 --search_wd $4 --search_task_id $SLURM_ARRAY_TASK_ID
