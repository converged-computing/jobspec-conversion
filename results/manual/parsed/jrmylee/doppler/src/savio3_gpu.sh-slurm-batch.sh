#!/bin/bash
#FLUX: --job-name=daniil
#FLUX: -n=8
#FLUX: --queue=v100_gpu3_normal
#FLUX: -t=108000
#FLUX: --urgency=16

module unload python/3.7
module load ml/tensorflow/2.5.0-py37 libsndfile
python train.py
