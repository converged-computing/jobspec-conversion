#!/bin/bash
#FLUX: --job-name=daniil
#FLUX: -c=2
#FLUX: --queue=savio2_gpu
#FLUX: -t=600
#FLUX: --priority=16

module unload python/3.7
module load ml/tensorflow/2.3.0-py37 libsndfile
python train.py
