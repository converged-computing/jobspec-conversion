#!/bin/bash
#FLUX: --job-name=hanky-leopard-9677
#FLUX: -n=10
#FLUX: -t=86400
#FLUX: --urgency=16

module add opencv
module add cuda/8.0
module add cudnn/6-cuda-8.0
python GAN_models.py
