#!/bin/bash
#FLUX: --job-name=gassy-hope-5027
#FLUX: -c=12
#FLUX: -t=604800
#FLUX: --urgency=16

./train.py --load train_log/fastrcnn/COCO-ResNet101-MaskRCNN.npz --original_lr_schedule --agnostic --second_head --logdir train_log/maskrcnn_two_heads_from_scratch/
