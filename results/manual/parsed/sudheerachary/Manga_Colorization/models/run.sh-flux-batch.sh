#!/bin/bash
#FLUX: --job-name=angry-toaster-9645
#FLUX: -t=86400
#FLUX: --priority=16

module add opencv
module add cuda/8.0
module add cudnn/6-cuda-8.0
python GAN_models.py
