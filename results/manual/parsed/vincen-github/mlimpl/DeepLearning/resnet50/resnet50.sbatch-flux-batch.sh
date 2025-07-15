#!/bin/bash
#FLUX: --job-name=fuzzy-lettuce-2815
#FLUX: -c=20
#FLUX: --urgency=16

PYTHON_PATH=/home/mawensen/project/miniconda3/envs/torch/bin
$PYTHON_PATH/python -u train.py
