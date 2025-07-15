#!/bin/bash
#FLUX: --job-name=$NAME
#FLUX: -n=4
#FLUX: -c=16
#FLUX: -t=345600
#FLUX: --urgency=16

cd ~/mask_bev
docker build -t mask_bev .
echo "check todo"
docker run --gpus all -e CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES --rm --ipc host \
  --mount type=bind,source="$(pwd)",target=/app/ \
  --mount type=bind,source="$(pwd)"/data/SemanticKITTI,target=/app/data/SemanticKITTI \
  --mount type=bind,source="$(pwd)"/data/KITTI,target=/app/data/KITTI \
  --mount type=bind,source="$(pwd)"/data/Waymo,target=/app/data/Waymo \
  --mount type=bind,source=/dev/shm,target=/dev/shm \
  mask_bev python3.10 train_mask_bev.py --config $CONFIG
