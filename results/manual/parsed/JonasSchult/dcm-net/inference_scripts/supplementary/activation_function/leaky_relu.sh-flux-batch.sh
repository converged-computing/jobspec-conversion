#!/bin/bash
#FLUX: --job-name=e_leaky_relu
#FLUX: -c=20
#FLUX: --priority=16

python run.py \
-c experiments/supplementary/activation_function/leaky_relu.json \
-r model_checkpoints/supplementary/activation_function/leaky_relu.pth \
-e \
-q
