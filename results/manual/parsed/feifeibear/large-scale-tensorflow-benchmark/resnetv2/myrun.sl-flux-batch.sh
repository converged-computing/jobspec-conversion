#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: -t=900
#FLUX: --urgency=16

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.2.1-CrayGNU-17.08-cuda-8.0-python3
srun -n 1 python3 input_test.py
