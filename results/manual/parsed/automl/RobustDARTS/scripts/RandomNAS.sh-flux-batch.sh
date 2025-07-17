#!/bin/bash
#FLUX: --job-name=RandomNAS
#FLUX: --queue=meta_gpu-ti
#FLUX: --urgency=16

source activate pytorch-0.3.1-cu8-py36
python src/search/randomNAS/random_weight_share.py --job_id $SLURM_ARRAY_JOB_ID --task_id $SLURM_ARRAY_TASK_ID --seed $SLURM_ARRAY_TASK_ID --epochs 50 --save experiments/search_logs_RandomNAS --space $1 --dataset $2 --drop_path_prob $3 --weight_decay $4
