#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=14400
#FLUX: --urgency=16

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install . src/guided-diffusion
NAME="GLIDE DIRE10 ResNet50" # name of the experiment
TYPE="images" # images or latent
DATA="$HOME/Latent-DIRE/data/glide"
MODEL="resnet50_pixel" # resnet50_pixel or resnet50_latent
CKPT="$HOME/Latent-DIRE/models/model.ckpt" 
python src/eval.py \
--name "$NAME" \
--type $TYPE \
--data_dir $DATA \
--model $MODEL \
--ckpt $CKPT \
--batch_size 256                                                             
