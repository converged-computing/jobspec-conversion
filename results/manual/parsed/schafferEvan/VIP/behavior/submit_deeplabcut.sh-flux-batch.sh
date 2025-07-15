#!/bin/bash
#FLUX: --job-name=reclusive-taco-1945
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='/mnt/home/evanschaffer/anaconda3/bin:$PATH'
export PYTHONPATH='/mnt/home/evanschaffer/anaconda3/envs/deeplabcut'

source activate deeplabcut
module load cuda/9.0.176 
module load cudnn/v7.0-cuda-9.0
module load gcc/7.4.0
export PATH=/mnt/home/evanschaffer/anaconda3/bin:$PATH
export PYTHONPATH=/mnt/home/evanschaffer/anaconda3/envs/deeplabcut
conda list
/mnt/home/evanschaffer/anaconda3/envs/deeplabcut/bin/python deeplabcut_train.py
