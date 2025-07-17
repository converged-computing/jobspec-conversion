#!/bin/bash
#FLUX: --job-name=adorable-nunchucks-1716
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

module load gcc/6.2.0
module load python/3.7.4
module load cuda/10.0
pipenv run python mnist_cnn_gpu.py
