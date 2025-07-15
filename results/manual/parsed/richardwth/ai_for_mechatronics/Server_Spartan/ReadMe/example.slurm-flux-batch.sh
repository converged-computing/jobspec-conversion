#!/bin/bash
#FLUX: --job-name=gan
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

module load Python/3.5.2-intel-2017.u2
module load Tensorflow/1.4.0-intel-2017.u2-Python-3.5.2-gpu
module load CUDA/8.0.44-intel-2017.u2
module load cuDNN/6.0-intel-2017.u2-CUDA-8.0.44
python job1/sngan_hinge.py
