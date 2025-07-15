#!/bin/bash
#FLUX: --job-name=yolo_small
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --priority=16

module load Python/3.6.4-intel-2018a
module load CUDA/9.1.85
module load tensorflow/1.5.0-foss-2016a-Python-3.5.2-CUDA-9.1.85
python train2.py
