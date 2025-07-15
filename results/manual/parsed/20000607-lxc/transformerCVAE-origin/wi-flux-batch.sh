#!/bin/bash
#FLUX: --job-name=wi
#FLUX: -c=8
#FLUX: --priority=16

cd /scratch/zt2080/shizhe/eres/transformerCVAE-origin
python train.py\
    --use_wandb\
    --iterations=25000\
    --warmup=250\
    --add_input\
    --add_attn\
    --add_softmax\
    --learn_prior\
