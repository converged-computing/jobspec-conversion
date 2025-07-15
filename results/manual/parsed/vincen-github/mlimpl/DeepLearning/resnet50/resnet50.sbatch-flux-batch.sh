#!/bin/bash
#FLUX: --job-name=anxious-bicycle-0588
#FLUX: -c=20
#FLUX: --priority=16

PYTHON_PATH=/home/mawensen/project/miniconda3/envs/torch/bin
$PYTHON_PATH/python -u train.py
