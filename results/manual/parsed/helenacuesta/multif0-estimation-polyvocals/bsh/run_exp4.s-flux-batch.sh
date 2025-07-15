#!/bin/bash
#FLUX: --job-name=exp7
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load cudnn/7.0v4.0
module load cuda/10.1.105
python 3_training_nophase.py --save_key exp7multif0 --data_splits_file data_splits.json
