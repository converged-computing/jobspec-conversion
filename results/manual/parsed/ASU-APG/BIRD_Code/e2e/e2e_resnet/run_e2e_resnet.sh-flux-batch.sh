#!/bin/bash
#FLUX: --job-name=muffled-omelette-7111
#FLUX: -n=4
#FLUX: --queue=cidsegpu1
#FLUX: -t=259920
#FLUX: --urgency=16

module load tensorflow/1.8-agave-gpu
source ~/work/code/pytorch1_0/bin/activate
cd /home/tgokhale/work/code/e2e_resnet
python3 test.py --learning_rate 0.005 --loss_type mse --batch_size 64 --val_batch_size 64
