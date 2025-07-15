#!/bin/bash
#FLUX: --job-name=gloopy-peanut-butter-5483
#FLUX: --queue=students-prod
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID:" $SLURM_ARRAY_TASK_ID
python face_extraction.py $SLURM_ARRAY_TASK_ID
