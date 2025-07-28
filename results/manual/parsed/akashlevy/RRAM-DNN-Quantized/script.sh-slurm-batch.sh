#!/bin/bash
#FLUX: --job-name=ornery-poodle-7441
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

ml python/3.6.1
ml py-tensorflow/2.4.1_py36
ml cuda/11.5.0
ml cudnn/8.1.1.33
python3 inference-char.py $SLURM_ARRAY_TASK_ID
