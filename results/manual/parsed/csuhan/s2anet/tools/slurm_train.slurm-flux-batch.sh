#!/bin/bash
#FLUX: --job-name=gassy-fudge-7379
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load scl/gcc4.9
module load nvidia/cuda/10.0
nvidia-smi
./tools/dist_train.sh \
  configs/dota/s2anet_r50_fpn_1x.py 4
