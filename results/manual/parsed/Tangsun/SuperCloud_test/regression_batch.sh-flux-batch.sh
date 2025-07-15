#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: --urgency=16

source /etc/profile
module load anaconda/2023a
module load cuda/11.6
module load nccl/2.11.4-cuda11.6
python regression_pytorch.py
