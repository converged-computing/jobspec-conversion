#!/bin/bash
#FLUX: --job-name=gpu-job
#FLUX: -n=24
#FLUX: --queue=sgpu-testing
#FLUX: -t=10800
#FLUX: --priority=16

​
​module purge
module load cuda
module load cudnn
​
nvidia-smi
conda activate csci5922
python -m src.rnn-deep-learning.py
