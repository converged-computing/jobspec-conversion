#!/bin/bash
#FLUX: --job-name=attention-rcnn
#FLUX: -c=4
#FLUX: --queue=ialab-high
#FLUX: -t=604800
#FLUX: --urgency=16

pyenv/bin/python3 train.py  --model attentionrcnn \
--max_epochs 10 \
--premodel resnet \
--attribute beautiful \
--wd 0.00001 \
--lr 0.001  \
--batch_size 32 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag attn_resnet_drop \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--sgd \
--lr_decay \
--ft 
