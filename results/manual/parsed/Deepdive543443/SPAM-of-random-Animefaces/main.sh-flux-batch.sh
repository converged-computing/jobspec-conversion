#!/bin/bash
#FLUX: --job-name=stanky-hope-1054
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load Anaconda3/2022.10
module load cuDNN/8.0.4.30-CUDA-11.1.1
source activate torch2
python train.py
