#!/bin/bash
#FLUX: --job-name=cowy-peas-4699
#FLUX: -c=8
#FLUX: --queue=students-prod
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID:" $SLURM_ARRAY_TASK_ID
python face_extraction.py $SLURM_ARRAY_TASK_ID
