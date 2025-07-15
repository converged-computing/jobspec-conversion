#!/bin/bash
#FLUX: --job-name=NN-FINN
#FLUX: --priority=16

module load gcc/latest
module load nvidia/7.5
module load cudnn/7.5-v5
python train.py --function train_net --data_path tif/ --save_dir vgg5 --batch_size 256 --lr 0.0022 --log_after 5 --cuda 1 --device 0
