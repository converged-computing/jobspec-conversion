#!/bin/bash
#FLUX: --job-name=goodbye-fork-3020
#FLUX: -t=86400
#FLUX: --urgency=16

module add opencv
module add cuda/8.0
module add cudnn/6-cuda-8.0
python GAN_models.py
