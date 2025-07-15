#!/bin/bash
#FLUX: --job-name=virtual_screen
#FLUX: -t=259200
#FLUX: --priority=16

echo "Starting task $SLURM_ARRAY_TASK_ID"
python3 dock_df.py -t drd3 -df data/split/split_batch_${SLURM_ARRAY_TASK_ID}.csv -o data/scored/scored_${SLURM_ARRAY_TASK_ID}.csv -s cedar
