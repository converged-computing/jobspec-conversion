#!/bin/bash
#FLUX: --job-name=swampy-bits-2406
#FLUX: --priority=16

module load tensorflow/1.8-agave-gpu
source ~/work/code/pytorch1_0/bin/activate
cd /home/tgokhale/work/code/e2e_resnet
python3 test.py --learning_rate 0.005 --loss_type mse --batch_size 64 --val_batch_size 64
