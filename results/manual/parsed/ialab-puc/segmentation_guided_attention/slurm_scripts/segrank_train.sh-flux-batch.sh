#!/bin/bash
#FLUX: --job-name=segrank15-rcnn
#FLUX: -c=4
#FLUX: --queue=ialab-high
#FLUX: -t=604800
#FLUX: --urgency=16

pyenv/bin/python3 train.py  --model segrank \
--max_epochs 40 \
--premodel resnet \
--attribute safety \
--wd 0 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag 15_drop_2d \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--softmax
