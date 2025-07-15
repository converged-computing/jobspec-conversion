#!/bin/bash
#FLUX: --job-name=trak
#FLUX: -c=8
#FLUX: --priority=16

MODEL_ID=$SLURM_ARRAY_TASK_ID
python featurize_and_score.py --model_id $MODEL_ID
