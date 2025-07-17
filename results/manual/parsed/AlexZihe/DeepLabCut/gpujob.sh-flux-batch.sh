#!/bin/bash
#FLUX: --job-name=blue-destiny-9248
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load gcc/6.2.0 cuda/9.0 python/3.6.0
source GPUIDpaw2/bin/activate
cd /home/zz90/DeepLabCut-100by100/pose-tensorflow/models/reachingJan30-trainset95shuffle1/train
python3 /home/zz90/DeepLabCut-100by100/pose-tensorflow/train.py
