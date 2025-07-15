#!/bin/bash
#FLUX: --job-name=salted-buttface-4425
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

module load tensorflow/1.13.1-cuda10.0-cudnn7.6-py3.6
module load keras/2.2.4-cuda10.0-cudnn7.6-py3.6
module load anaconda3/4.4.0
python trainCNN.py
