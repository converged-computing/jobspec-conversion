#!/bin/bash
#FLUX: --job-name=hello-peanut-8464
#FLUX: -t=21600
#FLUX: --priority=16

/usr/bin/env /home/idanta/anaconda3/envs/lama/bin/python SEED-Bench/BLIP2_eval_reprhasing.py --question_type_id $SLURM_ARRAY_TASK_ID --dataset_path /home/idanta/data/SEED/SEED-Bench-image/reconstruction/rephrased/fully_processed
