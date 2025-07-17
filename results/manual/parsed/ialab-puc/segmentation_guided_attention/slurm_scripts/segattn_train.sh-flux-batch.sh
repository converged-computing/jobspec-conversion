#!/bin/bash
#FLUX: --job-name=segattn-rcnn
#FLUX: -c=4
#FLUX: --queue=ialab-high
#FLUX: -t=604800
#FLUX: --urgency=16

export PATH='$PATH:/usr/local/cuda-10.0/bin'
export CUDADIR='/usr/local/cuda-10.0'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64'

export PATH=$PATH:/usr/local/cuda-10.0/bin
export CUDADIR=/usr/local/cuda-10.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64
pyenv/bin/python3 train.py  --model segattn \
--max_epochs 30 \
--premodel resnet \
--attribute wealthy \
--wd 0 \
--lr 0.001  \
--batch_size 4 \
--dataset ../datasets/placepulse  \
--model_dir ../storage/models_seg  \
--tag large_images \
--csv votes/ \
--attention_normalize local \
--n_layers 1 --n_heads 1 --n_outputs 1 \
--eq --cuda \
--cm \
--softmax \
--pbar \
--ft 
