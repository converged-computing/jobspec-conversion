#!/bin/bash
#FLUX: --job-name=DARTS_grid
#FLUX: --queue=1080Ti
#FLUX: --urgency=16

source activate pytorch-0.3.1-cu8-py36
python src/search/train_search.py --unrolled --job_id $SLURM_ARRAY_JOB_ID --task_id $SLURM_ARRAY_TASK_ID --seed $SLURM_ARRAY_TASK_ID --cutout --report_freq_hessian 2 --space $1 --dataset $2 --drop_path_prob $3 --weight_decay $4
