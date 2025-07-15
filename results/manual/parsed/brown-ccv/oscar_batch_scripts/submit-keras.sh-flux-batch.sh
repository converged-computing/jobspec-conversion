#!/bin/bash
#FLUX: --job-name=purple-taco-5934
#FLUX: -t=1800
#FLUX: --priority=16

module load keras/2.0.9
module load cuda/8.0.61 cudnn/5.1 tensorflow/1.1.0_gpu
python mnist_cnn.py
