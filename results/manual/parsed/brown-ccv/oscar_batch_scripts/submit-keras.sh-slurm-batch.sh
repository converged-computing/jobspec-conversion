#!/bin/bash
#FLUX: --job-name=MyKerasJob
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

module load keras/2.0.9
module load cuda/8.0.61 cudnn/5.1 tensorflow/1.1.0_gpu
python mnist_cnn.py
