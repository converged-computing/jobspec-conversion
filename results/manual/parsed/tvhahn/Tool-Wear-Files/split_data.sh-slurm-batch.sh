#!/bin/bash
#FLUX: --job-name=blue-snack-4154
#FLUX: -t=600
#FLUX: --urgency=16

echo "Starting task $SLURM_ARRAY_TASK_ID"
DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" input_folders)
module load scipy-stack/2019b
python create_split_data.py $DIR
