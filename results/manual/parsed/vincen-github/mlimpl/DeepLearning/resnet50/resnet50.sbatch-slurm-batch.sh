#!/bin/bash
#FLUX: --job-name=resnet50_pretraining
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: --urgency=16

PYTHON_PATH=/home/mawensen/project/miniconda3/envs/torch/bin
$PYTHON_PATH/python -u train.py
