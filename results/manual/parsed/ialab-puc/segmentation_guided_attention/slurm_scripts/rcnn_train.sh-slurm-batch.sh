#!/bin/bash
#FLUX: --job-name=rcnn-rcnn
#FLUX: -c=4
#FLUX: --queue=ialab-high
#FLUX: -t=604800
#FLUX: --urgency=16

pyenv/bin/python3 train.py  --model rcnn \
--max_epochs 10 \
--premodel resnet \
--attribute beautiful \
--wd 0.00001 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag rcnn \
--csv votes/ \
--eq --cuda \
--cm \
--sgd \
--ft
