#!/bin/bash
#FLUX: --job-name=chest_new_50
#FLUX: -c=2
#FLUX: --queue=2080ti
#FLUX: --urgency=16

module add cuda/10.1
module add gcc/8.4.0
python mytrain.py --data_name chestmnist --start_epoch 0 --end_epoch 100 --model_name resnet50
