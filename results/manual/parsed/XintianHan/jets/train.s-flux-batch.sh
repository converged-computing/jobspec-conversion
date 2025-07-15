#!/bin/bash
#FLUX: --job-name=JetsTrain%j
#FLUX: --priority=16

PYTHONARGS="$@"
PYTHONARGS="$PYTHONARGS --slurm --gpu 0 --slurm_array_job_id $SLURM_ARRAY_JOB_ID --slurm_array_task_id $SLURM_ARRAY_TASK_ID"
python train.py $PYTHONARGS
