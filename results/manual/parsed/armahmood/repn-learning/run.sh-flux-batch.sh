#!/bin/bash
#FLUX: --job-name=repn_learning
#FLUX: -t=4200
#FLUX: --urgency=16

python learner_xrel.py --search --save_losses --cfg ./cfg_temp/$SLURM_ARRAY_TASK_ID.json
