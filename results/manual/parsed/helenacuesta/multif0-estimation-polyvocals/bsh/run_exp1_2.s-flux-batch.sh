#!/bin/bash
#FLUX: --job-name=exp2
#FLUX: -t=518400
#FLUX: --priority=16

module purge
module load cudnn/7.0v4.0
module load cuda/10.1.105
python 2_training.py --model model2 --save_key exp2multif0 --data_splits_file data_splits.json
