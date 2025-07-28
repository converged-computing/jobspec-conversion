#!/bin/bash
#FLUX: --job-name=pointnet
#FLUX: -c=8
#FLUX: --queue=v100
#FLUX: -t=36000
#FLUX: --urgency=16

python train.py --model pointnet_cls --dataset TUBerlin --epoch 500  --batch_size 32 --num_category 250
