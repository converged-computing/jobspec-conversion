#!/bin/bash
#FLUX: --job-name=adorable-muffin-1357
#FLUX: --priority=16

module load gcc/6.2.0
module load python/3.7.4
module load cuda/10.0
pipenv run python mnist_cnn_gpu.py
